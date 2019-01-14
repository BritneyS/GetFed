//
//  FoodSearchViewController.swift
//  GetFed
//
//  Created by Britney Smith on 11/19/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit
import CoreData

class FoodSearchViewController: UIViewController {
    
    // MARK - Outlets
    @IBOutlet var foodTableView: UITableView!
    
    // MARK - Properties
    var searchController: UISearchController!
    var url: URL?
    var searchResults: SearchResults?
    var selectedIndex: Int?
    var foodEntries: [Food] = []
    var foodArray: [Food] = []
    var filteredFoodArray: [Food] = []
    var foodEntryIndexPath: IndexPath? = nil
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerFoodResultTableViewCell()
        foodTableView.dataSource = self
        foodTableView.delegate = self
        setupSearchBar()
        populateFoodEntriesArray()
        definesPresentationContext = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK - Methods
    func populateFoodEntriesArray() {
        print("🌸 Populating food array")
        CoreDataManager.sharedManager.fetchAllRecords { (foodRecords: [Food]) in
            self.foodEntries = foodRecords
            for food in self.foodEntries {
                food.isUserAdded = true
                print("🍦 Food record: \(food.label), \(food.nutrients.calories)")
            }
            self.populateFoodArray()
        }
    }
    
    func populateFoodArray() {
        for entry in foodEntries {
            foodArray.append(entry)
        }
        self.foodTableView.reloadData()
    }
    
    func deleteFoodEntry(deleteAlertAction: UIAlertAction) {
        if let indexPath = foodEntryIndexPath {
            foodTableView.beginUpdates()
            let foodEntryToDelete = foodArray[indexPath.row]
            CoreDataManager.sharedManager.deleteEntryByLabel(foodLabel: foodEntryToDelete.label)
            
            foodArray.remove(at: indexPath.row)
            foodTableView.deleteRows(at: [indexPath], with: .fade)
            
            CoreDataManager.sharedManager.saveContext()
            foodTableView.endUpdates()
        }
    }
    
    func cancelFoodEntryDeletion(cancelAlertAction: UIAlertAction) {
        foodEntryIndexPath = nil
    }
    
    func deleteConfirmationAlert(for entry: Food) {
        let alert = UIAlertController(title: "Delete Food Entry?", message: "Are you sure that you want to delete this food entry for \(entry.label)?", preferredStyle: .alert)
        let confirmDeletion = UIAlertAction(title: "Delete", style: .destructive, handler: deleteFoodEntry)
        let cancelDeletion = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelFoodEntryDeletion)
        
        alert.addAction(confirmDeletion)
        alert.addAction(cancelDeletion)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}

// MARK - UITableViewDataSource & UITableViewDelegate Protocol Implementation
extension FoodSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerFoodResultTableViewCell() {
        let cell = UINib(nibName: NibID.FoodResultTableViewCell.rawValue, bundle: nil)
        foodTableView.register(cell, forCellReuseIdentifier: CellID.foodSearchResultCell.rawValue)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if foodArray.count != 0 {
            return foodArray.count
        } else {
            return filteredFoodArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellID.foodSearchResultCell.rawValue, for: indexPath) as? FoodResultTableViewCell else {
            fatalError("Fatal error: No cell")
        }
        cell.foodLabel.text = foodArray[indexPath.row].label
        cell.brandLabel.text = foodArray[indexPath.row].brand
        cell.showImage(isUserAdded: foodArray[indexPath.row].isUserAdded)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? FoodResultTableViewCell
        selectedIndex = indexPath.row
        performSegue(withIdentifier: SegueID.foodSearchToFoodDetailSegue.rawValue, sender: cell)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            foodEntryIndexPath = indexPath
            let foodEntry = foodArray[indexPath.row]
            deleteConfirmationAlert(for: foodEntry)
        }
    }
}

// MARK - Segue Data Passing
extension FoodSearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case SegueID.foodSearchToFoodDetailSegue.rawValue:
            guard let foodDetailViewController = segue.destination as? FoodDetailViewController,
                  let selectedIndex = selectedIndex
            else { return }
            let selectedFood = foodArray[selectedIndex]
            foodDetailViewController.food = selectedFood
        default:
            return
        }
    }
}

// MARK - UISearchBarDelegate Protocol Implementation
extension FoodSearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func setupSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "ex: \"Cookies\""
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func getSearchText() -> String? {
        let searchBar = searchController.searchBar
        let searchText = searchBar.text
        return searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("👍 pressed")
        guard let inputText = searchBar.text,
              let url = APIClient.shared.setURL(with: inputText)
        else { return }
        
        if !inputText.isEmpty {
            makeRequest(with: url)
        } else {
            print("No text")
            /// TODO: alert "please enter text"
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("🌽 Food filtered")
        if let searchText = getSearchText() {
            if !searchText.isEmpty {
                filteredFoodArray = foodEntries.filter { searchTerm in
                    return searchTerm.label.lowercased().contains(searchText.lowercased())
                }
               foodArray = filteredFoodArray
            }
        } else {
            foodArray = foodEntries
        }
        for food in foodArray {
            print("🍇 \(food)")
        }
        foodTableView.reloadData()
    }
}
// MARK - API Request
extension FoodSearchViewController {
    
    func makeRequest(with url: URL) {
        APIClient.shared.fetchData(url: url) { (results: SearchResults) in
            self.searchResults = results
            if let searchResults = self.searchResults {
                print(results)
                for foodResult in searchResults.results {
                    self.foodArray.append(foodResult.food!)
                }
                for food in self.foodArray {
                    print("🍋 \(food)")
                }
                self.foodTableView.reloadData()
            } else {
                print("No results!")
            }
        }
    }
}
