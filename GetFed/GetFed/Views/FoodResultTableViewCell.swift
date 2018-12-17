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
    @IBOutlet var userAddedImage: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK - Methods
    func showImage(isUserAdded: Bool) {
        if isUserAdded {
            userAddedImage.image = UIImage(named: "user-created.png")
        } else {
            userAddedImage.image = UIImage(named: "blank-transparent.png")
        }
    }
    
}
