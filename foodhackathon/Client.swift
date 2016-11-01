//
//  Client.swift
//  Dialysis Nutrition Tracker
//
//  Created by Steven Chen on 7/1/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//

import Foundation

class Client : NSObject{
    
    let APISearchURL = "http://api.nal.usda.gov/ndb/search/"
    let APIReportURL = "http://api.nal.usda.gov/ndb/reports/"
    
    
    func searchFoodItemsUSDADatabase(_ searchString:String, dataSouce:String, completionHandler: @escaping (_ success:Bool, _ foodItemsArray:[[String:AnyObject]]?, _ error: String?) -> Void) {
        
        let methodParameters: [String: AnyObject] = [
            "api_key":          "HVBePg5RGhFz8twmpGD2t2BZx7pW6XiTTNpNWwj2" as AnyObject,
            "format":           "json" as AnyObject,                // result format
            "ds"    :           dataSouce as AnyObject,             // Data source. Either 'Branded Food Products' or 'Standard Reference
            "q"     :           searchString as AnyObject,          // Terms requested and used in the search
            "sort"  :           "r" as AnyObject,                   // Sort the results by food name(n) or by search relevance(r)
            "max"   :           "100" as AnyObject,                 // Maximum rows to return
            "offset":           "0" as AnyObject                    // Beginning row in the result set to begin
        ]
        
        let session = URLSession.shared
        let urlString = APISearchURL + escapedParameters(methodParameters)
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        print(request)
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error in
            
            // if an error occurs, print it and re-enable the UI
            func displayError(_ error: String) {
                print("URL at time of error: \(url)")
                completionHandler(false, nil, "Server error. Please try again laster")
                return
            }
            
            if error == nil{
                let parsedResult: AnyObject!
                
                if let data = data {
                    do {
                        parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
                        
                    } catch {
                        displayError("Could not parse the data as JSON: '\(data)'")
                        completionHandler(false, nil, "Server error. Please try again later")
                        
                        return
                    }
                    
                    guard let list = parsedResult["list"] as? [String: AnyObject] else {
                        print("food list not found")
                        completionHandler(false, nil, "No results found")
                        
                        return
                    }
                    
                    guard let foodItems = list["item"] as? [[String:AnyObject]] else {
                        print("food items not found")
                        completionHandler(false, nil, "No results found")
                        
                        return
                    }
                    
                    completionHandler(true, foodItems, nil)
                }
            }
        })
        task.resume();
    }
    
    func getFoodNutrientUSDADatabase(_ ndbno:String, completionHandler: @escaping (_ success:Bool, _ nutrientsArray:[[String:AnyObject]]?, _ error: String?) -> Void) {
        let methodParameters: [String: AnyObject] = [
            "api_key":          "HVBePg5RGhFz8twmpGD2t2BZx7pW6XiTTNpNWwj2" as AnyObject,
            "ndbno":            ndbno as AnyObject,                          // NDB no
            "type":             "b" as AnyObject,                             // Report type: [b]asic, [f]ull, [s]tats
            "format":          "json" as AnyObject                          // report formt: xml or json
        ]
        
        let session = URLSession.shared
        let urlString = APIReportURL + escapedParameters(methodParameters)
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        print(request)
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error in
            
            // if an error occurs, print it and re-enable the UI
            func displayError(_ error: String) {
                completionHandler(false, nil, "Server error. Please try again laster")
                return
            }
            if error == nil{
                let parsedResult: AnyObject!
                
                if let data = data {
                    do {
                        parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject!
                    } catch {
                        completionHandler(false, nil, "Server error. Please try again later")
                        return
                    }
                    //      print(parsedResult)
                    guard let report = parsedResult["report"] as? [String: AnyObject] else {
                        print("nutrient report not found")
                        completionHandler(false, nil, "Server error. Please try again later")
                        
                        return
                    }
                    
                    guard let food = report["food"] as? [String:AnyObject] else {
                        print("error retriving food")
                        completionHandler(false, nil, "Server error. Please try again later")
                        return
                    }
                    
                    guard let nutrients = food["nutrients"] as? [[String:AnyObject]] else {
                        print("error retriving nutrients")
                        completionHandler(false, nil, "Server error. Please try again later")
                        
                        return
                    }
                    
                    completionHandler(true, nutrients, nil)
                }
            }
            
        })
        task.resume();
    }
    
    
    fileprivate func escapedParameters(_ parameters: [String: AnyObject]) -> String{ // input named parameter of type dictionary, returns type string
        
        if parameters.isEmpty{
            return " "
        }else{
            var keyValuePairs = [String]()
            
            for (key, value) in parameters{
                // make sure it's a string value
                let stringValue = "\(value)"
                
                // escape it
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                
                // append it
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
            }
            return "?\(keyValuePairs.joined(separator: "&"))"
        }
    }
    
    // MARK: Shared Instance
    class func sharedInstance() -> Client {
        struct Singleton {
            static var sharedInstance = Client()
        }
        return Singleton.sharedInstance
    }
}
