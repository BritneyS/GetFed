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
    @IBOutlet var caloriesLabel: UILabel!
    @IBOutlet var brandNameLabel: UILabel!
    
    // MARK - Properties
    var food: Food?

    
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
        guard let food = food,
            let nutrients = food.nutrients,
            let foodName = food.label,
            let brandName = food.brand,
            let calories = nutrients.calories,
            let protein = nutrients.protein,
            let carbs = nutrients.carbs,
            let fat = nutrients.fat
        else { return }
        foodNameLabel.text = foodName
        brandNameLabel.text = brandName
        caloriesLabel.text = "Calories: \(calories)"
        
        print("Protein: \(protein), Carbs: \(carbs), Fat: \(fat)")
    }

}
