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
    
//    private let measurementFormatter = MeasurementFormatter()
//
//    public func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
//
//        let valueInGrams = Measurement(value: value, unit: UnitMass.grams)
//        measurementFormatter.unitOptions = .providedUnit
//
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .none
//        measurementFormatter.numberFormatter = numberFormatter
//
//        return measurementFormatter.string(for: valueInGrams)!
//    }
    
    private var measurementFormatter: MeasurementFormatter = {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitOptions = .providedUnit
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        measurementFormatter.numberFormatter = numberFormatter
        return measurementFormatter
    }()
    
    public func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let valueInGrams = Measurement(value: value, unit: UnitMass.grams)
        return measurementFormatter.string(for: valueInGrams)!
    }
}
