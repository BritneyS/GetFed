//
//  FoodEntryViewController.swift
//  GetFed
//
//  Created by Britney Smith on 12/4/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit

class FoodEntryViewController: UIViewController {
    
    // MARK - Outlets
    @IBOutlet var foodTextField: CustomTextField!
    @IBOutlet var brandTextField: CustomTextField!
    @IBOutlet var caloriesTextField: CustomTextField!
    @IBOutlet var proteinTextField: CustomTextField!
    @IBOutlet var carbsTextField: CustomTextField!
    @IBOutlet var fatTextField: CustomTextField!
    
    // MARK - Properties
    lazy var foodStorageManager = { () -> FoodStorageManager in
        let manager = FoodStorageManager()
        return manager
    }()
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK - Methods
    func savedRecordAlert() {
        let successAlert = UIAlertController(title: "Success!", message: "New food entry for \"\(foodTextField.text!)\" was saved successfully!", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(successAlert, animated: true, completion: nil)
    }
    
    func failedSaveRecordAlert() {
        let failureAlert = UIAlertController(title: "Uh oh!", message: "Error when saving new food entry.", preferredStyle: .alert)
        failureAlert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
        self.present(failureAlert, animated: true, completion: nil)
    }
    
    func clearTextFields() {
        foodTextField.text = nil
        brandTextField.text = nil
        caloriesTextField.text = nil
        proteinTextField.text = nil
        carbsTextField.text = nil
        fatTextField.text = nil
    }
    
    // MARK - Actions
    @IBAction func cancel(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        view.endEditing(true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        print("🍞 Food: \(foodTextField.text)")
        print("🍞 Brand: \(brandTextField.text)")
        print("🍞 Calories: \(caloriesTextField.text)")
        print("🍞 Protein: \(proteinTextField.text)")
        print("🍞 Carbs: \(carbsTextField.text)")
        print("🍞 Fat: \(fatTextField.text)")
        view.endEditing(true)
        saveNewFood()
    }
}

// MARK - Core Data Management
extension FoodEntryViewController {
    
    func saveNewFood() {
        
        guard let foodLabel = foodTextField.text,
              let brand = brandTextField.text,
              let caloriesValue = Double(caloriesTextField.text ?? ""),
              let proteinValue = Double(proteinTextField.text ?? ""),
              let carbsValue = Double(carbsTextField.text ?? ""),
              let fatValue = Double(fatTextField.text ?? "")
            else { return }
        
        _ = foodStorageManager.insertFood(label: foodLabel, brand: brand, calories: caloriesValue, protein: proteinValue, carbs: carbsValue, fat: fatValue)
        foodStorageManager.saveContext()
        
        if foodStorageManager.isSaved == true {
            savedRecordAlert()
            clearTextFields()
        } else {
            failedSaveRecordAlert()
        }
    }
}
