//
//  Nutrient.swift
//  foodhackathon
//
//  Created by JasonDu on 2016-10-29.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation

class Nutrient {
    var nutrientName:String = ""
    var unit:String = ""
    var food:Food?
    var measurements:[Measurement] = []
    var val:String = ""
    
    init(nutrientName:String, unit:String){
        
        self.nutrientName = nutrientName
        self.unit = unit
        
    }
}
