//
//  FoodDetailViewController.swift
//  GetFed
//
//  Created by Britney Smith on 11/26/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import UIKit
import Charts

class FoodDetailViewController: UIViewController {

    // MARK - Outlets
    @IBOutlet var foodNameLabel: UILabel!
    @IBOutlet var caloriesLabel: UILabel!
    @IBOutlet var brandNameLabel: UILabel!
    @IBOutlet var macroNutrientChart: PieChartView!
    
    // MARK - Properties
    var food: Food?
    var protein: Double?
    var carbs: Double?
    var fat: Double?
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        populateLabels()
        chartSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    // MARK - Methods
    func populateLabels() {
        print("Food: \(food)")
        
        if let food = food {
            let nutrients = food.nutrients
            let foodName = food.label
            
            foodNameLabel.text = foodName
            
            if let brandName = food.brand {
                brandNameLabel.text = brandName
            } else {
                brandNameLabel.isHidden = true
            }
            
            if let calories = nutrients.calories {
                let caloriesString = String(format: "%.0f", calories)
                caloriesLabel.text = "Calories: \(caloriesString)"
            } else {
                caloriesLabel.text = "No calorie data"
            }
            
            if let protein = nutrients.protein {
                self.protein = protein
                print("Protein: \(self.protein!)")
            } else {
                self.protein = nil
            }
            
            if let carbs = nutrients.carbs {
                self.carbs = carbs
                print("Carbs: \(self.carbs!)")
            } else {
                self.carbs = nil
            }
            
            if let fat = nutrients.fat {
                self.fat = fat
                print("Fat: \(self.fat!)")
            } else {
                self.fat = nil
            }
        } else {
            foodNameLabel.text = "No food data"
            brandNameLabel.isHidden = true
            caloriesLabel.isHidden = true
        }
    }

}

// MARK - Pie Chart Methods
extension FoodDetailViewController {
    
    func chartSetup() {
        let dataSet = populateMacroNutrientChartData()
        formatChartValues(with: dataSet)
        styleMacroNutrientChart(with: dataSet)
    }
    
    func populateMacroNutrientChartData() -> PieChartDataSet? {
        guard let proteinData = self.protein else {
            print("No protein data")
            return nil
        }
        
        guard let carbsData = self.carbs else {
            print("No carbs data")
            return nil
        }
        
        guard let fatData = self.fat else {
            print("No fat data")
            return nil
        }
        
        let entryOne = PieChartDataEntry(value: proteinData, label: "Protein")
        let entryTwo = PieChartDataEntry(value: carbsData, label: "Carbs")
        let entryThree = PieChartDataEntry(value: fatData, label: "Fat")
        let dataEntries = [entryOne, entryTwo, entryThree]
        
        let dataSet = PieChartDataSet(values: dataEntries, label: "samplechartlabel")
        let data = PieChartData(dataSet: dataSet)
        macroNutrientChart.data = data
        
        print("Chart data: \(macroNutrientChart.data?.dataSets)")
        
        /// Keep as the last line before return
        macroNutrientChart.notifyDataSetChanged()
        return dataSet
    }
    
    func formatChartValues(with dataSet: PieChartDataSet?) {
        if let dataSet = dataSet {
            let measurementFormatter = MeasurementFormatter()
            let customValueFormatter = CustomValueFormatter(measurementFormatter: measurementFormatter)
            dataSet.valueFormatter = customValueFormatter
        }
    }
    
    func styleMacroNutrientChart(with dataSet: PieChartDataSet?) {
        
        macroNutrientChart.animate(yAxisDuration: 0.9, easingOption: .easeInSine)
        macroNutrientChart.legend.enabled = false
        
        if let dataSet = dataSet {
            let chartLabelColor = UIColor(red:0.38, green:0.07, blue:0.33, alpha:1.0)
            guard let customFont = UIFont(name:"HelveticaNeue-Bold", size: 18.0) else { return }
            dataSet.colors = ChartColorTemplates.customTemplateBright()
            dataSet.valueTextColor = chartLabelColor
            dataSet.valueFont = customFont
            dataSet.xValuePosition = .outsideSlice
            dataSet.yValuePosition = .outsideSlice
            dataSet.valueLineColor = chartLabelColor
            dataSet.valueLinePart1Length = 0.45
            dataSet.valueLinePart2Length = 0.1
        }
    }
}
