//
//  Identity.swift
//  GetFed
//
//  Created by Britney Smith on 11/16/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation

enum Identity: String {
    case homeVC
    
    case homeToFoodSearchSegue

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
    
}

