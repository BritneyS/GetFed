//
//  CoreDataManager.swift
//  GetFed
//
//  Created by Britney Smith on 12/12/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    // MARK - Properties
    static let sharedManager = CoreDataManager()
    lazy var managedContext: NSManagedObjectContext = {
        return CoreDataManager.sharedManager.persistentContainer.viewContext
    }()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GetFed")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
}
