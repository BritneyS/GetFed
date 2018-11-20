//
//  FoodSearchViewController.swift
//  GetFed
//
//  Created by Britney Smith on 11/19/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit

class FoodSearchViewController: UIViewController {
    
    // MARK - Properties
    let apiClient = APIClient()
    let appId = EdamamAppID
    let appKey = EdamamAppKey
    var url: URL?
    var text = ""
    var searchResults: SearchResults?
    
    // MARK - Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        makeRequest(with: URL(string: "[redacted]")!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK - Methods
    
    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func getSearchText() -> String? {
        let searchBar = navigationItem.searchController?.searchBar
        let searchText = searchBar?.text
        return searchText
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
        guard let text = navigationItem.searchController?.searchBar.text else { return }
        apiClient.fetchData(url: url) { (results: SearchResults) in
            //load data into searchResults
            self.searchResults = results
            print(results)
        }
    }
}
