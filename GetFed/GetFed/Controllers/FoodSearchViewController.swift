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
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerFoodResultTableViewCell()
        foodTableView.dataSource = self
        foodTableView.delegate = self
        setupSearchBar()
        definesPresentationContext = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

// MARK - UITableViewDataSource & UITableViewDelegate Protocol Implementation
extension FoodSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerFoodResultTableViewCell() {
        let cell = UINib(nibName: NibID.FoodResultTableViewCell.rawValue, bundle: nil)
        foodTableView.register(cell, forCellReuseIdentifier: CellID.foodSearchResultCell.rawValue)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rowCount = searchResults?.results.count else { return 0 }
        return (rowCount == 0) ? 1 : rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellID.foodSearchResultCell.rawValue, for: indexPath) as? FoodResultTableViewCell else {
            fatalError("Fatal error: No cell")
        }
        if let searchResults = searchResults {
            cell.foodLabel.text = searchResults.results[indexPath.row].food.label
            cell.brandLabel.text = searchResults.results[indexPath.row].food.brand
        } else {
            cell.foodLabel.text = "No food data"
            cell.brandLabel.isHidden = true
        }
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
                  let selectedIndex = selectedIndex,
                  let searchResults = searchResults
            else { return }
            let selectedFood = searchResults.results[selectedIndex].food
            foodDetailViewController.food = selectedFood
        default:
            return
        }
    }
}

// MARK - UISearchBarDelegate Protocol Implementation
extension FoodSearchViewController: UISearchBarDelegate {
    
    func setupSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
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
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        ///
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
            self.foodTableView.reloadData()
        }
    }
}
