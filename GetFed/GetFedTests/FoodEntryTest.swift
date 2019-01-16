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
        foodEntryVC = storyboard.instantiateViewController(withIdentifier: "foodEntryVC") as? FoodEntryViewController
        //_ = foodEntryVC.view // to call viewDidLoad
    }

    override func tearDown() {
        foodEntryVC = nil
        super.tearDown()
    }
    
    func testFoodEntryViewControllerExists() {
        XCTAssertNotNil(foodEntryVC.view)
    }
    
//    func testAllTextFieldsExist() {
//        XCTAssertTrue(foodEntryVC.foodTextField.exists, "Food Name textfield missing") // error
//
//    }

//    func testInputForLabelFieldRecieved() {
//        // 1. given
//        let foodLabelField = foodEntryVC.foodTextField
//        let brandField = foodEntryVC.brandTextField
//        let caloriesField = foodEntryVC.caloriesTextField
//        let proteinField = foodEntryVC.proteinTextField
//        let carbsField = foodEntryVC.carbsTextField
//        let fatField = foodEntryVC.fatTextField
//
//        // 2. when
//
//
//        // 3. then
//    }
}
