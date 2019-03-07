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
    @IBOutlet var proteinLabel: UILabel!
    @IBOutlet var carbsLabel: UILabel!
    @IBOutlet var fatLabel: UILabel!
    
    
    // MARK - Properties
    var food: Food?
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkMacronutrientData()
        populateLabels()
        chartSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    // MARK - Methods
    func checkMacronutrientData() {
        if food?.nutrients.protein == nil || food?.nutrients.carbs == nil || food?.nutrients.fat == nil {
            proteinLabel.isHidden = true
            carbsLabel.isHidden = true
            fatLabel.isHidden = true
        }
    }
    
    func populateLabels() {
        print("🍞 Food: \(food)")
        
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
                caloriesLabel.text = "Calories: \(Int(truncating: calories))"
            } else {
                caloriesLabel.text = "No calorie data"
            }
            
            if let protein = nutrients.protein {
                proteinLabel.text = "\(Int(truncating: protein))g"
            } else {
                proteinLabel.isHidden = true
            }
            
            if let carbs = nutrients.carbs {
                carbsLabel.text = "\(Int(truncating: carbs))g"
            } else {
                carbsLabel.isHidden = true
            }
            
            if let fat = nutrients.fat {
                fatLabel.text = "\(Int(truncating: fat))g"
            } else {
                fatLabel.isHidden = true
            }
            
        } else {
            foodNameLabel.text = "No food data"
            brandNameLabel.isHidden = true
            caloriesLabel.isHidden = true
            proteinLabel.isHidden = true
            carbsLabel.isHidden = true
            fatLabel.isHidden = true
        }
    }
}

// MARK - Pie Chart Methods
extension FoodDetailViewController {
    
    func chartSetup() {
        guard let food = food else {
            //TODO error handling
            print("No food object for chart")
            return
        }
        let dataSet = populateMacroNutrientChartData(food: food)
        formatChartValues(with: dataSet)
        styleMacroNutrientChart(with: dataSet)
    }
    
    func populateMacroNutrientChartData(food: Food) -> PieChartDataSet? {

        guard let proteinData = food.nutrients.protein else {
            print("No protein data")
            return nil
        }
        
        guard let carbsData = food.nutrients.carbs else {
            print("No carbs data")
            return nil
        }
        
        guard let fatData = food.nutrients.fat else {
            print("No fat data")
            return nil
        }
        
        let entryOne = PieChartDataEntry(value: Double(truncating: proteinData), label: "Protein")
        let entryTwo = PieChartDataEntry(value: Double(truncating: carbsData), label: "Carbs")
        let entryThree = PieChartDataEntry(value: Double(truncating: fatData), label: "Fat")
        let dataEntries = [entryOne, entryTwo, entryThree]
        
        let dataSet = PieChartDataSet(values: dataEntries, label: "per 100 grams")
        let data = PieChartData(dataSet: dataSet)
        macroNutrientChart.data = data
        
        print("Chart data: \(macroNutrientChart.data?.dataSets)")
        
        /// Keep as the last line before return
        macroNutrientChart.notifyDataSetChanged()
        return dataSet
    }
    
    func formatChartValues(with dataSet: PieChartDataSet?) {
        if let dataSet = dataSet {
            dataSet.valueFormatter = CustomValueFormatter()
        }
    }
    
    func styleMacroNutrientChart(with dataSet: PieChartDataSet?) {
        
        guard let legendFont = UIFont(name:"HelveticaNeue-Bold", size: 18.0) else { return }
        macroNutrientChart.animate(yAxisDuration: 0.9, easingOption: .easeInSine)
        macroNutrientChart.legend.font = legendFont
        macroNutrientChart.legend.formSize = 20.0
        macroNutrientChart.legend.orientation = .horizontal
        macroNutrientChart.legend.horizontalAlignment = .center
        macroNutrientChart.drawEntryLabelsEnabled = false
        
        if let dataSet = dataSet {
            let chartLabelColor = UIColor(red:0.38, green:0.07, blue:0.33, alpha:1.0)
            guard let customFont = UIFont(name:"HelveticaNeue-Bold", size: 18.0) else { return }
            dataSet.drawValuesEnabled = false
            dataSet.colors = ChartColorTemplates.customTemplateBright()
            dataSet.valueTextColor = chartLabelColor
            dataSet.valueFont = customFont
            dataSet.valueLineColor = chartLabelColor
        }
    }
}
