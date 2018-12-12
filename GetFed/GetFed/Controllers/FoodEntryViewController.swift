//
//  FoodEntryViewController.swift
//  GetFed
//
//  Created by Britney Smith on 12/4/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit
import CoreData

class FoodEntryViewController: UIViewController {
    
    // MARK - Outlets
    @IBOutlet var foodTextField: CustomTextField!
    @IBOutlet var brandTextField: CustomTextField!
    @IBOutlet var caloriesTextField: CustomTextField!
    @IBOutlet var proteinTextField: CustomTextField!
    @IBOutlet var carbsTextField: CustomTextField!
    @IBOutlet var fatTextField: CustomTextField!
    
    // MARK - Properties
    var foodRecords: [Food] = []
    
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
        readRecords()
    }
}

// MARK - Core Data Management
extension FoodEntryViewController {
    
    func saveNewFood() {
//        guard let foodEntity = NSEntityDescription.entity(forEntityName: "Food", in: managedContext) else { return }
//        guard let nutrientsEntity = NSEntityDescription.entity(forEntityName: "Nutrients", in: managedContext) else { return }
//
//        let enteredFood = NSManagedObject(entity: foodEntity, insertInto: managedContext)
//        let enteredNutrients = NSManagedObject(entity: nutrientsEntity, insertInto: managedContext)
        
//        enteredFood.setValue(foodTextField.text, forKey: "label")
//        enteredFood.setValue(brandTextField.text, forKey: "brand")
        
        guard let caloriesValue = caloriesTextField.text,
              let proteinValue = proteinTextField.text,
              let carbsValue = carbsTextField.text,
              let fatValue = fatTextField.text
            else { return }
        
//        if let caloriesInt = Int(caloriesValue) {
//            enteredNutrients.setValue(NSNumber(value: caloriesInt), forKey: "calories")
//        }
//        
//        if let proteinInt = Int(proteinValue) {
//            enteredNutrients.setValue(NSNumber(value: proteinInt), forKey: "protein")
//        }
//        
//        if let carbsInt = Int(carbsValue) {
//            enteredNutrients.setValue(NSNumber(value: carbsInt), forKey: "carbs")
//        }
//        
//        if let fatInt = Int(fatValue) {
//            enteredNutrients.setValue(NSNumber(value: fatInt), forKey: "fat")
//        }
//        
//        enteredFood.setValue(enteredNutrients, forKey: "nutrients")
        
        do {
            try managedContext.save()
            savedRecordAlert()
            clearTextFields()
        } catch {
            failedSaveRecordAlert()
            print("Save error: \(error)")
        }
    }
    /// temporary method for testing purposes
    func readRecords() {
        let foodFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Food")
        do {
            foodRecords = try managedContext.fetch(foodFetch) as! [Food]
            for record in foodRecords {
                print("🍎 Food record: \(record.label), \(record.nutrients.calories)")
            }
        } catch {
            print("Fetch error: \(error)")
        }
    }
}
