//
//  FoodEntryTest.swift
//  GetFedTests
//
//  Created by Britney Smith on 1/15/19.
//  Copyright © 2019 Britney Smith. All rights reserved.
//

import XCTest
import Foundation
import UIKit
@testable import GetFed

class FoodEntryTest: XCTestCase {

    var foodEntryVC: UIViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        foodEntryVC = storyboard.instantiateViewController(withIdentifier: "foodEntryVC")
        let _ = foodEntryVC.view // to call viewDidLoad
    }

    override func tearDown() {
        foodEntryVC = nil
        super.tearDown()
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
