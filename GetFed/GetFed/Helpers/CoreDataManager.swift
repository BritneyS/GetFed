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
    var isSaved = false
    
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

// MARK: Core Data Record Updates
extension CoreDataManager {
    
    func insertNewFood(label: String, brand: String, calories: Double, protein: Double, carbs: Double, fat: Double) {
        guard let foodEntity = NSEntityDescription.entity(forEntityName: "Food", in: managedContext) else { return }
        guard let nutrientsEntity = NSEntityDescription.entity(forEntityName: "Nutrients", in: managedContext) else { return }
        let enteredFood = NSManagedObject(entity: foodEntity, insertInto: managedContext)
        let enteredNutrients = NSManagedObject(entity: nutrientsEntity, insertInto: managedContext)
        let caloriesInt = Int(calories)
        let proteinInt = Int(protein)
        let carbsInt = Int(carbs)
        let fatInt = Int(fat)
        
        enteredFood.setValue(label, forKey: "label")
        enteredFood.setValue(brand, forKey: "brand")
        
        enteredNutrients.setValue(NSNumber(value: caloriesInt), forKey: "calories")
        enteredNutrients.setValue(NSNumber(value: proteinInt), forKey: "protein")
        enteredNutrients.setValue(NSNumber(value: carbsInt), forKey: "carbs")
        enteredNutrients.setValue(NSNumber(value: fatInt), forKey: "fat")
        
        enteredFood.setValue(enteredNutrients, forKey: "nutrients")
        
        do {
            try managedContext.save()
            isSaved = true
        } catch {
            isSaved = false
            print("Save error: \(error)")
        }
    }
    
    func fetchAllRecords(queue: DispatchQueue = .main, completion: @escaping ([Food]) -> ()) {
        let foodFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Food")
        do {
            let records = try managedContext.fetch(foodFetch) as! [Food]
//            for record in records {
//                print("🍎 Food record: \(record.label), \(record.nutrients.calories)")
//            }
            queue.async { completion(records) }
        } catch {
            print("Fetch error: \(error)")
        }
    }
}
