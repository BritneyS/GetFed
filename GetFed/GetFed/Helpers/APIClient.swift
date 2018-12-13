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

class APIClient {
    
    func parseData(_ data: Data) -> SearchResults? {
        //guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
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
