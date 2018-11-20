//
//  APIClient.swift
//  GetFed
//
//  Created by Britney Smith on 11/19/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    let appId = EdamamAppID
    let appKey = EdamamAppKey
    var url: URL?
    var text = ""
    
    init(text: String) {
        self.text = text
        self.url = setURL(with: self.text)
    }
    
    func setURL(with searchText: String) -> URL? {
        guard let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        let urlString = String(format: "https://api.edamam.com/api/food-database/parser?ingr=%@&app_id=\(appId)&app_key=\(appKey)", encodedText)
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
    
    func parseData(_ data: Data) -> SearchResults? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(SearchResults.self, from: data)
            return result
        } catch {
            print("Error in parsing: \(error)")
            return nil
        }
    }
    
    func fetchData(url: URL, queue: DispatchQueue = .main, completion: @escaping (SearchResults) -> ()) {
        Alamofire.request(url).responseData { response in
            if let data = response.result.value {
                guard let result = self.parseData(data) else { return }
                queue.async { completion(result) }
            }
        }
    }
    
    

}
