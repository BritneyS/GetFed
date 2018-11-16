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

    var viewControllerID: String {
        switch self {
        case .homeVC:
            return "homeViewController"
        }
    }
    
}

