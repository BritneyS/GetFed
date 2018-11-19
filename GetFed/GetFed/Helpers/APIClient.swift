//
//  APIClient.swift
//  GetFed
//
//  Created by Britney Smith on 11/19/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation

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
    
    

}
