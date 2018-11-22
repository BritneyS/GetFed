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
    
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
