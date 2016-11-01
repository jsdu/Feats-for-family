//
//  Food.swift
//  foodhackathon
//
//  Created by JasonDu on 2016-10-29.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation

class Food {
    var name : String = ""
    var ndbno : String = ""
    var mealType : String = ""
    var servingSize: String = ""
    var numberOfServings: Float = 0.0
    var date:String = ""
    var index:NSNumber = 0.0
    var nutrients : [Nutrient] = []
    
    init(name:String, ndbno:String, mealType:String, index:Int, numberOfServings:Float, date:String){
    
    self.name = name
    self.ndbno = ndbno
    self.mealType = mealType
    self.index = index as NSNumber
    self.numberOfServings = numberOfServings
    self.date = date
    }
}
