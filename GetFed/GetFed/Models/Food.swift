//
//  Food.swift
//  GetFed
//
//  Created by Britney Smith on 11/17/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

import Foundation

struct SearchResults {
    let results: [Food]
    
    enum SearchResultsCodingKeys: String, CodingKey {
        case results = "hints"
    }
    
    struct Food {
        let label: String
        let nutrients: Nutrient
        
        struct Nutrient {
            let calories: Double
            let protein: Double
            let fat: Double
            let carbs: Double
            
            enum NutrientCodingKeys: String, CodingKey {
                case calories = "ENERC_KCAL"
                case protein = "PROCNT"
                case fat = "FAT"
                case carbs = "CHOCDF"
            }
        }
    } 
}



let sampleURL = "https://api.edamam.com/api/food-database/parser?ingr=red%20apple&app_id={your app_id}&app_key={your app_key}"

let sampleData = """
{
  "text": "gala apple",
  "parsed": [],
  "hints": [
    {
      "food": {
        "foodId": "food_ashlcg6b4ansska87l39xb0dnupz",
        "label": "gala apple",
        "nutrients": {
          "ENERC_KCAL": 57,
          "PROCNT": 0.25,
          "FAT": 0.12,
          "CHOCDF": 13.68
        },
        "source": "Generic"
      },
      "measures": [
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_kilogram",
          "label": "Kilogram"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_gram",
          "label": "Gram"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_pound",
          "label": "Pound"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_ounce",
          "label": "Ounce"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_serving",
          "label": "Serving"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_cup",
          "label": "Cup"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_unit",
          "label": "Whole"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_liter",
          "label": "Liter"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_milliliter",
          "label": "Milliliter"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_cubic_inch",
          "label": "Cubic inch"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_quart",
          "label": "Quart"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_drop",
          "label": "Drop"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_gallon",
          "label": "Gallon"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_dash",
          "label": "Dash"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_fluid_ounce",
          "label": "Fluid ounce"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_pint",
          "label": "Pint"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_pinch",
          "label": "Pinch"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_teaspoon",
          "label": "Teaspoon"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_tablespoon",
          "label": "Tablespoon"
        },
        {
          "uri": "http://www.edamam.com/ontologies/edamam.owl#Measure_dessert_spoon",
          "label": "Dessert spoon"
        }
      ]
    }
  ],
  "_links": {
    "next": {
      "title": "Next page",
      "href": "https://api.edamam.com/api/food-database/parser?session=40&ingr=gala+apple"
    }
  }
}
""".data(using: .utf8)
