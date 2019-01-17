//
//  FoodStorageManagerTests.swift
//  GetFedTests
//
//  Created by Britney Smith on 1/17/19.
//  Copyright © 2019 Britney Smith. All rights reserved.
//

import XCTest
import CoreData
@testable import GetFed

class FoodStorageManagerTests: XCTestCase {
    
    var systemUnderTest: FoodStorageManager!
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
        return managedObjectModel
    }()
    lazy var mockPersistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GetFed", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType /// in-memory store separate from production persistent store
        description.shouldAddStoreAsynchronously = false /// for testing
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            
            /// Check if the data store is in memory
            precondition(description.type == NSInMemoryStoreType, "Failure in FoodStorageManagerTest : Data store not in memory")
            
            if let error = error {
                fatalError("Creation of in-memory coodinator failed: \(error)")
            }
        }
        return container
    }()
    
    func createTestStubs() {
        func insertTestFood(label: String, brand: String, calories: Double, protein: Double, carbs: Double, fat: Double) -> Food? {
            let foodItem = NSEntityDescription.insertNewObject(forEntityName: "Food", into: mockPersistentContainer.viewContext) as! Food
            let nutrientItem = NSEntityDescription.insertNewObject(forEntityName: "Nutrients", into: mockPersistentContainer.viewContext) as! Nutrients
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
        
        insertTestFood(label: "food1", brand: "brand1", calories: 500, protein: 30, carbs: 15, fat: 10)
        insertTestFood(label: "food2", brand: "brand2", calories: 400, protein: 50, carbs: 20, fat: 8)
        insertTestFood(label: "food3", brand: "brand3", calories: 800, protein: 8, carbs: 80, fat: 50)
        insertTestFood(label: "food4", brand: "brand4", calories: 300, protein: 50, carbs: 8, fat: 30)
        insertTestFood(label: "food5", brand: "brand5", calories: 600, protein: 10, carbs: 50, fat: 25)
        
        do {
            try mockPersistentContainer.viewContext.save()
        } catch {
            print("Save error: \(error)")
        }
    }
    
    func flushData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Food")
        let records = try! mockPersistentContainer.viewContext.fetch(fetchRequest)
        for case let record as NSManagedObject in records {
            mockPersistentContainer.viewContext.delete(record)
        }
        try! mockPersistentContainer.viewContext.save()
    }

    override func setUp() {
        super.setUp()
        createTestStubs()
        systemUnderTest = FoodStorageManager(persistentContainer: mockPersistentContainer)
    }

    override func tearDown() {
        flushData()
        super.tearDown()
    }

    func testCreateFoodEntry() {
        
        // given
        let label = "Food6"
        let brand = "Brand6"
        let calories = 600.0
        let protein = 30.0
        let carbs = 15.0
        let fat = 10.0
        
        // when
        let insertedFood = systemUnderTest.insertFood(label: label, brand: brand, calories: calories, protein: protein, carbs: carbs, fat: fat)
        
        // then
        XCTAssertNotNil(insertedFood)
    }

}
