//
//  ColorTemplate.swift
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
        return [
            //UIColor(red:0.80, green:0.73, blue:0.93, alpha:1.0) /* lavender */,
            UIColor(red:0.75, green:0.84, blue:0.92, alpha:1.0) /* pale aqua */,
            UIColor(red:0.01, green:0.99, blue:0.73, alpha:1.0) /* aqua */,
            UIColor(red:0.91, green:0.89, blue:0.36, alpha:1.0) /* pale yellow */
            //UIColor(red:0.91, green:0.87, blue:0.00, alpha:1.0) /* yellow */
        ]
    }
}
