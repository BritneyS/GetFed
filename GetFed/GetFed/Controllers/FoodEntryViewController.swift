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
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    
    
}
