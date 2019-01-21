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

public extension NSManagedObject {
    
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
    
}

class FoodStorageManagerTests: XCTestCase {
    
    var systemUnderTest: FoodStorageManager!
    var mockPersistentContainer: NSPersistentContainer? = nil
//    lazy var managedObjectModel: NSManagedObjectModel = {
//        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
//        return managedObjectModel
//    }()
//    
    //var managedObjectModel: NSManagedObjectModel!
    
//    lazy var mockPersistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "GetFed", managedObjectModel: self.managedObjectModel)
//        let description = NSPersistentStoreDescription()
//        description.type = NSInMemoryStoreType /// in-memory store separate from production persistent store
//        description.shouldAddStoreAsynchronously = false /// for testing
//
//        container.persistentStoreDescriptions = [description]
//        container.loadPersistentStores { (description, error) in
//
//            /// Check if the data store is in memory
//            precondition(description.type == NSInMemoryStoreType, "Failure in FoodStorageManagerTest : Data store not in memory")
//
//            if let error = error {
//                fatalError("Creation of in-memory coodinator failed: \(error)")
//            }
//        }
//        return container
//    }()
    
    func createMockPersistentContainer() {
        mockPersistentContainer = NSPersistentContainer(name: "GetFed")//, managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType /// in-memory store separate from production persistent store
        //description.shouldAddStoreAsynchronously = false /// for testing
        
        mockPersistentContainer!.persistentStoreDescriptions = [description]
        mockPersistentContainer!.loadPersistentStores { (description, error) in
        
        /// Check if the data store is in memory
        precondition(description.type == NSInMemoryStoreType, "Failure in FoodStorageManagerTest : Data store not in memory")
        
            if let error = error {
                fatalError("Creation of in-memory coodinator failed: \(error)")
            }
        }
    }
    
    func createTestStubs() {
        func insertTestFood(label: String, brand: String, calories: Double, protein: Double, carbs: Double, fat: Double) -> Food? {
            let foodItem = NSEntityDescription.insertNewObject(forEntityName: "Food", into: mockPersistentContainer!.viewContext) as! Food
            let nutrientItem = NSEntityDescription.insertNewObject(forEntityName: "Nutrients", into: mockPersistentContainer!.viewContext) as! Nutrients
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
        
        let _ = insertTestFood(label: "food1", brand: "brand1", calories: 500, protein: 30, carbs: 15, fat: 10)
        let _ = insertTestFood(label: "food2", brand: "brand2", calories: 400, protein: 50, carbs: 20, fat: 8)
        let _ = insertTestFood(label: "food3", brand: "brand3", calories: 800, protein: 8, carbs: 80, fat: 50)
        let _ = insertTestFood(label: "food4", brand: "brand4", calories: 300, protein: 50, carbs: 8, fat: 30)
        let _ = insertTestFood(label: "food5", brand: "brand5", calories: 600, protein: 10, carbs: 50, fat: 25)
        
        do {
            try mockPersistentContainer!.viewContext.save()
        } catch {
            print("Save error: \(error)")
        }
    }
    
    func flushData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Food")
        let records = try! mockPersistentContainer!.viewContext.fetch(fetchRequest)
        for case let record as NSManagedObject in records {
            mockPersistentContainer!.viewContext.delete(record)
        }
        try! mockPersistentContainer!.viewContext.save()
    }
    
    func destroyPersistentStore() {
//        if let storeURL = mockPersistentContainer?.persistentStoreCoordinator.persistentStores.first?.url {
//
//            do {
//                try mockPersistentContainer?.persistentStoreCoordinator.destroyPersistentStore(at: storeURL, ofType: NSInMemoryStoreType, options: nil)
//            } catch {
//                print("Failure in destroying test store: \(error)")
//            }
//
//        } else {
//            print("No store url")
//        }
        
        mockPersistentContainer = nil
    }
    
    override func setUp() {
        super.setUp()
        
//        if (managedObjectModel == nil) {
//            managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
//        }
        
        createMockPersistentContainer()
        createTestStubs()
        systemUnderTest = FoodStorageManager(persistentContainer: mockPersistentContainer!)
    }

    override func tearDown() {
        flushData()
        destroyPersistentStore()
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
    
    func testSaveFoodEntry() {
        
    }
    
    func testFetchAllFoodEntries() {

        // given

        // when
        let results = systemUnderTest.fetchAll()

        // then
        XCTAssertEqual(results.count, 5)
    }
    
    func testDeleteFoodEntry() {
        
        // given
        let foodItems = systemUnderTest.fetchAll()
        let food = foodItems[0]
        let foodCount = foodItems.count
        
        // when
        systemUnderTest.deleteRecordBy(objectID: food.objectID)
        systemUnderTest.saveRecord()
        
        //then
        XCTAssertEqual(numberOfItemsInPersistentStore(), foodCount - 1)
    }
}

extension FoodStorageManagerTests {
    func numberOfItemsInPersistentStore() -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Food")
        let results = try! mockPersistentContainer!.viewContext.fetch(request)
        return results.count
    }
}
