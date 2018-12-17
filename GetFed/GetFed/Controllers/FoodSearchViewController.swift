//
//  FoodSearchViewController.swift
//  GetFed
//
//  Created by Britney Smith on 11/19/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit

class FoodSearchViewController: UIViewController {
    
    // MARK - Outlets
    @IBOutlet var foodTableView: UITableView!
    
    // MARK - Properties
    var searchController: UISearchController!
    let apiClient = APIClient()
    let appId = EdamamAppID
    let appKey = EdamamAppKey
    var url: URL?
    var searchResults: SearchResults?
    var selectedIndex: Int?
    var foodEntries: [Food] = []
    var foodArray: [Food] = []
    var filteredFoodArray: [Food] = []
    
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
            self.populateFoodArray()
            for food in self.foodEntries {
                print("🍦 Food record: \(food.label), \(food.nutrients.calories)")
            }
        }
    }
    
    func populateFoodArray() {
        for entry in foodEntries {
            foodArray.append(entry)
        }
        self.foodTableView.reloadData()
    }
}

// MARK - UITableViewDataSource & UITableViewDelegate Protocol Implementation
extension FoodSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerFoodResultTableViewCell() {
        let cell = UINib(nibName: NibID.FoodResultTableViewCell.rawValue, bundle: nil)
        foodTableView.register(cell, forCellReuseIdentifier: CellID.foodSearchResultCell.rawValue)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //guard let rowCount = searchResults?.results.count else { return 0 }
        //let rowCount = foodArray.count
        //return (rowCount == 0) ? 0 : rowCount
        if foodArray.count != 0 {
//            if filteredFoodArray.count == 0 {
//                return foodArray.count
//            } else {
//                return filteredFoodArray.count
//            }
            return foodArray.count
        } else {
            //return 0
            return filteredFoodArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellID.foodSearchResultCell.rawValue, for: indexPath) as? FoodResultTableViewCell else {
            fatalError("Fatal error: No cell")
        }
//        if let searchResults = searchResults {
//            guard let food = searchResults.results[indexPath.row].food else { fatalError() }
//            cell.foodLabel.text = food.label
//            cell.brandLabel.text = food.brand
//        } else {
//            cell.foodLabel.text = "No food data"
//            cell.brandLabel.isHidden = true
//        }
        cell.foodLabel.text = foodArray[indexPath.row].label
        cell.brandLabel.text = foodArray[indexPath.row].brand
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? FoodResultTableViewCell
        selectedIndex = indexPath.row
        performSegue(withIdentifier: SegueID.foodSearchToFoodDetailSegue.rawValue, sender: cell)
    }
}

// MARK - Segue Data Passing
extension FoodSearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case SegueID.foodSearchToFoodDetailSegue.rawValue:
            guard let foodDetailViewController = segue.destination as? FoodDetailViewController,
                  let selectedIndex = selectedIndex//,
                  //let searchResults = searchResults
            else { return }
            //let selectedFood = searchResults.results[selectedIndex].food
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
              let url = setURL(with: inputText)
        else { return }
        
        if !inputText.isEmpty {
            makeRequest(with: url)
        } else {
            print("No text")
            /// TODO: alert "please enter text"
        }
        //foodTableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("🌽 Food filtered")
        if let searchText = getSearchText() {
            if !searchText.isEmpty {
                filteredFoodArray = foodEntries.filter { searchTerm in
                    return searchTerm.label.lowercased().contains(searchText.lowercased())
                }
               foodArray = filteredFoodArray
//                for food in filteredFoodArray {
//                    foodArray.append(food)
//                }
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
    
    func setURL(with searchText: String) -> URL? {
        guard let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        let urlString = String(format: "https://api.edamam.com/api/food-database/parser?ingr=%@&app_id=\(appId)&app_key=\(appKey)", encodedText)
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
    
    func makeRequest(with url: URL) {
        apiClient.fetchData(url: url) { (results: SearchResults) in
            self.searchResults = results
            print(results)
            for foodResult in (self.searchResults?.results)! {
                self.foodArray.append(foodResult.food!)
            }
            for food in self.foodArray {
                print("🍋 \(food)")
            }
            DispatchQueue.main.async {
                self.foodTableView.reloadData()
            }
            self.foodTableView.reloadData()
        }
        //foodTableView.reloadData()
    }
}
