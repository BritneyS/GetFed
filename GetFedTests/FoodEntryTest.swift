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

    var foodEntryVC: FoodEntryViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        foodEntryVC = storyboard.instantiateViewController(withIdentifier: ViewControllerID.FoodEntryViewController.rawValue) as? FoodEntryViewController
        XCTAssertNotNil(foodEntryVC.view) // to call viewDidLoad
    }

    override func tearDown() {
        foodEntryVC = nil
        super.tearDown()
    }
    
    func testFoodTextFieldExists() {
        XCTAssertNotNil(foodEntryVC.foodTextField)
    }
    
    func testBrandTextFieldExists() {
        XCTAssertNotNil(foodEntryVC.brandTextField)
    }
    
    func testCaloriesTextFieldExists() {
        XCTAssertNotNil(foodEntryVC.caloriesTextField)
    }
    
    func testProteinTextFieldExists() {
        XCTAssertNotNil(foodEntryVC.proteinTextField)
    }
    
    func testCarbsTextFieldExists() {
        XCTAssertNotNil(foodEntryVC.carbsTextField)
    }
    
    func testFoodFatFieldExists() {
        XCTAssertNotNil(foodEntryVC.fatTextField)
    }
}
