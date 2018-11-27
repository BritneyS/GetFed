//
//  FoodDetailViewController.swift
//  GetFed
//
//  Created by Britney Smith on 11/26/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {

    // MARK - Outlets
    
    @IBOutlet var foodNameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    // MARK - Properties
    
    var foodName: String?
    var calories: String?
    var protein: Double?
    var carbs: Double?
    var fat: Double?
    
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK - Methods
    
    func populateLabels() {
        guard let foodName = foodName,
            let calories = calories,
            let protein = protein,
            let carbs = carbs,
            let fat = fat
            else { return }
        foodNameLabel.text = foodName
        caloriesLabel.text = "Calories: \(calories)"
        
        print("Protein: \(protein), Carbs: \(carbs), Fat: \(fat)")
    }

}
