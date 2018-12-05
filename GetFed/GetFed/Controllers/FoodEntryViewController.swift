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
    @IBOutlet var foodTextField: UITextField!
    @IBOutlet var brandTextField: UITextField!
    @IBOutlet var proteinTextField: UITextField!
    @IBOutlet var carbsTextField: UITextField!
    @IBOutlet var fatTextField: UITextField!
    @IBOutlet var foodLabel: UILabel!
    @IBOutlet var brandLabel: UILabel!
    @IBOutlet var proteinLabel: UILabel!
    @IBOutlet var carbsLabel: UILabel!
    @IBOutlet var fatLabel: UILabel!
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldPlaceholderText()
        setLabelText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK - Methods
    func setTextFieldPlaceholderText() {
        foodTextField.placeholder = "ex: \"cookies\""
        brandTextField.placeholder = "ex: \"Cookies Inc\""
        proteinTextField.placeholder = "ex: \"5\""
        carbsTextField.placeholder = "ex: \"35\""
        fatTextField.placeholder = "ex: \"15\""
    }
    
    func setLabelText() {
        foodLabel.text = "Food Name:"
        brandLabel.text = "Brand Name:"
        proteinLabel.text = "Protein amount in grams (per 100 grams)"
        carbsLabel.text = "Carbs amount in grams (per 100 grams)"
        fatLabel.text = "Fat amount in grams (per 100 grams)"
    }

    // MARK - Actions
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        print("🍞 Food: \(foodTextField.text)")
        print("🍞 Brand: \(brandTextField.text)")
        print("🍞 Protein: \(proteinTextField.text)")
        print("🍞 Carbs: \(carbsTextField.text)")
        print("🍞 Fat: \(fatTextField.text)")
    }
    
    
}
