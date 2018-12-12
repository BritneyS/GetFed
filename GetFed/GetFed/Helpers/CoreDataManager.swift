//
//  CoreDataManager.swift
//  GetFed
//
//  Created by Britney Smith on 12/12/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager/*: NSObject*/ {
    
    // MARK - Properties
    static let sharedManager = CoreDataManager()
    
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
    
    // MARK- Methods
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
