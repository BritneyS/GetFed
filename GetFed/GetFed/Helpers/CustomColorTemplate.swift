//
//  CustomColorTemplate.swift
//  GetFed
//
//  Created by Britney Smith on 11/28/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation
import UIKit
import Charts

extension ChartColorTemplates {
    
    public class func customTemplateBright() -> [UIColor] {
        guard let proteinColor = UIColor(named: "ProteinColor"),
              let carbsColor = UIColor(named: "CarbsColor"),
              let fatColor = UIColor(named: "FatColor")
            else {
                    print("No colors!")
                    return []
                 }
        return [proteinColor, carbsColor, fatColor]
    }
}
