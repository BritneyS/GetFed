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
        guard let proteinColor = UIColor(named: ColorID.ProteinColor.rawValue),
              let carbsColor = UIColor(named: ColorID.CarbsColor.rawValue),
              let fatColor = UIColor(named: ColorID.FatColor.rawValue)
            else {
                    print("No colors!")
                    return []
                 }
        return [proteinColor, carbsColor, fatColor]
    }
}
