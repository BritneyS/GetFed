//
//  FoodStorageManager.swift
//  GetFed
//
//  Created by Britney Smith on 1/17/19.
//  Copyright © 2019 Britney Smith. All rights reserved.
//

import Foundation
import CoreData

class FoodStorageManager {
    
    let persistentContainer: NSPersistentContainer!
    
    // MARK: Init with dependency
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    convenience init() {
        // Use default container for production environment
        let coreDataManager = CoreDataManager.sharedManager
        self.init(persistentContainer: coreDataManager.persistentContainer)
    }
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    var isSaved = false
}

// MARK: CRUD
extension FoodStorageManager {
    
    func insertFood(label: String, brand: String, calories: Double, protein: Double, carbs: Double, fat: Double) -> Food? {
        let foodItem = NSEntityDescription.insertNewObject(forEntityName: "Food", into: backgroundContext) as! Food
        let nutrientItem = NSEntityDescription.insertNewObject(forEntityName: "Nutrients", into: backgroundContext) as! Nutrients
        let caloriesInt = Int(calories)
        let proteinInt = Int(protein)
        let carbsInt = Int(carbs)
        let fatInt = Int(fat)
        
        foodItem.label = label
        foodItem.brand = brand
        
        nutrientItem.calories = NSNumber(value: caloriesInt)
        nutrientItem.protein = NSNumber(value: proteinInt)
        nutrientItem.carbs = NSNumber(value: carbsInt)
        nutrientItem.fat = NSNumber(value: fatInt)
        
        foodItem.nutrients = nutrientItem
        
        return foodItem
    }
}
