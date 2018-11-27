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
    
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodNameLabel.text = foodName
        caloriesLabel.text = "Calories: \(calories!)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

}
