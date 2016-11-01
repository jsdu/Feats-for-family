//
//  Measurement.swift
//  foodhackathon
//
//  Created by JasonDu on 2016-10-29.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation

class Measurement {
    
    var key:String = ""
    var value:String = ""
    var nutrient:Nutrient?
    
    init(key:String, value:String){
        self.key = key
        self.value = value
    }
}
