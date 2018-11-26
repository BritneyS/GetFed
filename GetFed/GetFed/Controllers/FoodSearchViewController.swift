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
    var text = ""
    var searchResults: SearchResults?
    
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
        let cell = UINib(nibName: Identity.foodResultTableViewCellNib.nibID, bundle: nil)
        foodTableView.register(cell, forCellReuseIdentifier: Identity.foodSearchResultCell.cellID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rowCount = searchResults?.results.count else { return 0 }
        return (rowCount == 0) ? 1 : rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identity.foodSearchResultCell.cellID, for: indexPath) as? FoodResultTableViewCell else {
            fatalError("Fatal error: No cell")
        }
        cell.foodLabel.text = searchResults?.results[indexPath.row].food.label
        cell.brandLabel.text = searchResults?.results[indexPath.row].food.brand
        return cell
    }
    
    /// TODO: didSelectRowAt
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
        //
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
