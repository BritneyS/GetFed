//
//  Identity.swift
//  GetFed
//
//  Created by Britney Smith on 11/16/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation

enum Identity: String {
    
    // ViewController Identifiers
    case homeVC
    
    // Segue Identifiers
    case homeToFoodSearchSegue
    
    // Cell Identifiers
    case foodSearchResultCell
    
    // Nib Identifiers
    case foodResultTableViewCellNib

    var viewControllerID: String {
        switch self {
        case .homeVC:
            return "homeViewController"
        default:
            return ""
        }
    }
    
    var segueID: String {
        switch self {
        case .homeToFoodSearchSegue:
            return "homeToFoodSearch"
        default:
            return ""
        }
    }
    
    var cellID: String {
        switch self {
        case .foodSearchResultCell:
            return "foodSearchResultCell"
        default:
            return ""
        }
    }
    
    var nibID: String {
        switch self {
        case .foodResultTableViewCellNib:
            return "FoodResultTableViewCell"
        default:
            return ""
        }
    }
    
}

