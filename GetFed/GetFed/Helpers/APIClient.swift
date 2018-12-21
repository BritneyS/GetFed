//
//  APIClient.swift
//  GetFed
//
//  Created by Britney Smith on 11/19/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

final class APIClient {
    
    let appId = EdamamAppID
    let appKey = EdamamAppKey
    static let shared = APIClient()
    
    func setURL(with searchText: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.edamam.com"
        urlComponents.path = "/api/food-database/parser"
        
        let queryIngredient = URLQueryItem(name: "ingr", value: searchText)
        let queryAppId = URLQueryItem(name: "app_id", value: appId)
        let queryAppKey = URLQueryItem(name: "app_key", value: appKey)
        urlComponents.queryItems = [queryAppKey, queryAppId, queryIngredient]
        
        guard let url = urlComponents.url else { fatalError("Error when creating URL") }
        return url
    }
    
    func parseData(_ data: Data) -> SearchResults? {
        let context = CoreDataManager.sharedManager.persistentContainer.newBackgroundContext()
        
        do {
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.context!] = context
            let result = try decoder.decode(SearchResults.self, from: data)
            return result
        } catch {
            print("Error in parsing: \(error)")
            return nil
        }
    }
    
    func fetchData(url: URL, queue: DispatchQueue = .main, completion: @escaping (SearchResults) -> ()) {
        Alamofire.request(url).validate().responseData { response in
            switch response.result {
            case .success:
                print("Successful server response!")
            case .failure(let error):
                print("Error in server response: \(error)")
            }
            
            if let data = response.result.value {
                guard let result = self.parseData(data) else { return }
                queue.async { completion(result) }
            }
        }
    }
    
    

}
