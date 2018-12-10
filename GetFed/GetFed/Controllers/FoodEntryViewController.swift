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
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
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
        /// TODO: alert: "Food Entry Saved!"
    }
}

// MARK - Core Data Management
extension FoodEntryViewController {
    
    func createManagedObjectModel() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return } /// fatalerror
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let foodEntity = NSEntityDescription.entity(forEntityName: "Food", in: managedContext) else { return }
        guard let nutrientsEntity = NSEntityDescription.entity(forEntityName: "Nutrients", in: managedContext) else { return }
        
        let enteredFood = NSManagedObject(entity: foodEntity, insertInto: managedContext)
        let enteredNutrients = NSManagedObject(entity: nutrientsEntity, insertInto: managedContext)
        
        enteredFood.setValue(foodTextField.text, forKey: "label")
        enteredFood.setValue(brandTextField.text, forKey: "brand")
        
        enteredNutrients.setValue(caloriesTextField.text, forKey: "calories")
        enteredNutrients.setValue(proteinTextField.text, forKey: "protein")
        enteredNutrients.setValue(carbsTextField.text, forKey: "carbs")
        enteredNutrients.setValue(fatTextField.text, forKey: "fat")
        
        enteredFood.setValue(enteredNutrients, forKey: "nutrients")
        
        do {
            try managedContext.save()
        } catch {
            print("Save error: \(error)")
        }
    }
}
