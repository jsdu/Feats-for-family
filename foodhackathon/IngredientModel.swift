//
//  IngredientModel.swift
//  RecipeBook
//
//  Created by Austins Work on 10/24/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

import Foundation

var ingredient : [String:[String]] =
    ["Meat":
            ["Chicken",
             "Steak",
             "Pork",
             "Ground Beef",
             "Trukey"],
    "Seafood":
            ["Fish",
            "Crab",
            "Shrimp",
            "Crawfish",
            "Lobster"],
    "Fruit":
            ["Apple",
            "Banana",
            "Orange",
            "Watermellon",
            "Strawberry"],
    "Vegetable":
            ["Onion",
            "Green Pepper",
            "Tomato",
            "Lettuce",
            "Carrot"],
    "Dairy Product":
            ["Cheese",
            "Milk",
            "Butter",
            "Yogurt"],
    "Staple Food":
            ["Rice",
            "Bread",
            "Pasta",
            "Beans",
            "Potatoe"]
]

public func getHeader(ingredient: [String:[String]]) -> [String]{
    var headerArray : [String] = []
    for (key,value) in ingredient{
        headerArray.append(key)
    }
    return headerArray

}

public func getValuesForHeader(header:String) -> [String]{
    var valueArray : [String] = []
    for (key, value) in ingredient{
        if key == header{
            for values in value{
                valueArray.append(values)
            }
        }
    }
    return valueArray
}





