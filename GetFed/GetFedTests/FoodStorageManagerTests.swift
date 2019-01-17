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

    override func setUp() {
        super.setUp()
        systemUnderTest = FoodStorageManager(persistentContainer: mockPersistentContainer)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
