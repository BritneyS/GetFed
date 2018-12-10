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
    @IBOutlet var proteinTextField: CustomTextField!
    @IBOutlet var carbsTextField: CustomTextField!
    @IBOutlet var fatTextField: CustomTextField!
    @IBOutlet var foodLabel: UILabel!
    @IBOutlet var brandLabel: UILabel!
    @IBOutlet var proteinLabel: UILabel!
    @IBOutlet var carbsLabel: UILabel!
    @IBOutlet var fatLabel: UILabel!
    
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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
    }
}
