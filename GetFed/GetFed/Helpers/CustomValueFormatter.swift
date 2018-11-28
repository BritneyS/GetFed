//
//  CustomValueFormatter.swift
//  GetFed
//
//  Created by Britney Smith on 11/28/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation
import Charts

public class CustomValueFormatter: NSObject, IValueFormatter {
    
    fileprivate var measurementFormatter: MeasurementFormatter?
    
    convenience init(measurementFormatter: MeasurementFormatter) {
        self.init()
        self.measurementFormatter = measurementFormatter
    }
    
    public func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        guard let measurementFormatter = measurementFormatter else { return "" }
        
        let valueInGrams = Measurement(value: value, unit: UnitMass.grams)
        measurementFormatter.unitOptions = .providedUnit
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        measurementFormatter.numberFormatter = numberFormatter
        
        return measurementFormatter.string(for: valueInGrams) ?? ""
    }
    
    
}
