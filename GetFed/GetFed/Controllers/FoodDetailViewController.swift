//
//  FoodDetailViewController.swift
//  GetFed
//
//  Created by Britney Smith on 11/26/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {

    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

}
