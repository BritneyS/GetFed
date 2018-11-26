//
//  FoodResultTableViewCell.swift
//  GetFed
//
//  Created by Britney Smith on 11/21/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit

class FoodResultTableViewCell: UITableViewCell {

    // MARK - Outlets
    
    @IBOutlet var foodLabel: UILabel!
    @IBOutlet var brandLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
