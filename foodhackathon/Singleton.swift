//
//  Singleton.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

final class Singleton {
    
    // Can't init is singleton
    private init() { }
    
    //MARK: Shared Instance
    
    static let sharedInstance: Singleton = Singleton()
    
    //MARK: Local Variable
    var ingredientsList : [String] = ["Blueberry"]
    var points:Int = 10
    var alertPts = 0
    var showAlert = false
}
