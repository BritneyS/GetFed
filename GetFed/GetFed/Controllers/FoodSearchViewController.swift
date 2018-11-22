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
    
    @IBOutlet weak var foodTableView: UITableView!
    
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
        let cell = UINib(nibName: "FoodResultTableViewCell", bundle: nil)
        foodTableView.register(cell, forCellReuseIdentifier: "foodSearchResultCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "foodSearchResultCell", for: indexPath) as? FoodResultTableViewCell else { return UITableViewCell() }
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
        if let text = searchBar.text {
            if !text.isEmpty {
                print("Text: \(text)")
                if let url = setURL(with: text) {
                    makeRequest(with: url)
                }
            } else {
                print("No text")
                /// TODO: alert "please enter text"
            }
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
        }
    }
}
