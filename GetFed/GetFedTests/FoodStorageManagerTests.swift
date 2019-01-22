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
    var saveNotificationCompletionHandler: ((Notification) -> ())?

    func createMockPersistentContainer() {
        mockPersistentContainer = NSPersistentContainer(name: "GetFed")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType /// in-memory store separate from production persistent store
        description.shouldAddStoreAsynchronously = false /// for testing
        
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
        
        _ = insertTestFood(label: "food1", brand: "brand1", calories: 500, protein: 30, carbs: 15, fat: 10)
        _ = insertTestFood(label: "food2", brand: "brand2", calories: 400, protein: 50, carbs: 20, fat: 8)
        _ = insertTestFood(label: "food3", brand: "brand3", calories: 800, protein: 8, carbs: 80, fat: 50)
        _ = insertTestFood(label: "food4", brand: "brand4", calories: 300, protein: 50, carbs: 8, fat: 30)
        _ = insertTestFood(label: "food5", brand: "brand5", calories: 600, protein: 10, carbs: 50, fat: 25)
        
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
        mockPersistentContainer = nil
    }
    
    override func setUp() {
        super.setUp()
        NotificationCenter.default.addObserver(self, selector: #selector(contextSaved(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil)
        createMockPersistentContainer()
        createTestStubs()
        systemUnderTest = FoodStorageManager(persistentContainer: mockPersistentContainer!)
    }
    
    

    override func tearDown() {
        flushData()
        destroyPersistentStore()
        super.tearDown()
    }
    
    func testSaveFoodEntry() {
        
        // given
        let label = "Food6"
        let brand = "Brand6"
        let calories = 600.0
        let protein = 30.0
        let carbs = 15.0
        let fat = 10.0
        
        let expect = expectation(description: "Context saved")
        
        waitForSavedNotification { notification in
            expect.fulfill()
            
        }
        
        _ = systemUnderTest.insertFood(label: label, brand: brand, calories: calories, protein: protein, carbs: carbs, fat: fat)
        
        // when
        systemUnderTest.saveRecord()
        
        // then
        waitForExpectations(timeout: 1, handler: nil)
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
    
    func testFetchAllFoodEntries() {

        // given
        var results: [Food] = []
        let expect = expectation(description: "Food entries retrieved")
        
        // when
        systemUnderTest.fetchAllRecords { (foodRecords: [Food]) in
            results = foodRecords
            
            expect.fulfill()
        }

        // then
        waitForExpectations(timeout: 5, handler: nil)
        
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
    
    func contextSaved(notification: Notification) {
        saveNotificationCompletionHandler?(notification)
    }
    
    func waitForSavedNotification(completionHandler: @escaping ((Notification) -> ())) {
        saveNotificationCompletionHandler = completionHandler
    }
}
