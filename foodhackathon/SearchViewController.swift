//
//  ViewController.swift
//  foodhackathon
//
//  Created by JasonDu on 2016-10-28.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit
import Spring
import GTProgressBar

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var SearchTableView: UITableView!
    @IBOutlet var SearchTextView: UITextField!
    
    @IBOutlet var nutrientView: SpringView!
    
    @IBOutlet var nutrientName: UILabel!
    
    @IBOutlet var nutrientPts: UILabel!
    
    @IBOutlet var energyProgress: GTProgressBar!
    
    @IBOutlet var intProgress: GTProgressBar!
    
    @IBOutlet var strengthProgress: GTProgressBar!
    
    @IBOutlet var healthProgress: GTProgressBar!
    
    var points:Int?
    
    var foodNames:[String] = []
    var ndbnoList:[String] = []
    var nutrientsArray = [[String:AnyObject]]()

    var selectedFoodName:String?
    var selectedFoodNdbno:String?
    
    var searchStr:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        if (searchStr != "") {
            SearchTextView.text = searchStr
            USDARequest()
        }
        //      Data source could be "Standard Reference" and "Branded Food Products"
        
        Client.sharedInstance().getFoodNutrientUSDADatabase("18240") {(success, nutrientsArray, errorString) in
            if success && nutrientsArray != nil{
                
//                print(nutrientsArray)
//                let detailedViewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailedView") as! DetailedViewController
//                
//                detailedViewController.foodNdbno = foodNdbno
//                detailedViewController.foodName = foodName
//                detailedViewController.mealType = self.mealType!
//                detailedViewController.foodIndex = self.foodIndex!
//                detailedViewController.nutrientsArray = nutrientsArray!
//                detailedViewController.date = self.date!
//                detailedViewController.isEdit = false
//                detailedViewController.delegate = self.mealsViewController
//                
//                DispatchQueue.main.async(execute: {
//                    self.navigationController?.pushViewController(detailedViewController, animated: true)
//                });
//            }else{
//                AlertView.displayError(self, title: "Alert", error: errorString!)
//            }
            }
        }

        

    }
    
    
    
    func USDARequest(){
        Client.sharedInstance().searchFoodItemsUSDADatabase(SearchTextView.text!, dataSouce: "Standard Reference")
        {(success, foodItemsArray, errorString) in
            if success && foodItemsArray != nil {
                
                for foodItem in foodItemsArray!{
                    let foodName = foodItem["name"] as? String
                    let ndbno = foodItem["ndbno"] as? String
                    
                    self.foodNames.append(foodName!)
                    self.ndbnoList.append(ndbno!)
                }
                DispatchQueue.main.async(execute: {
                    self.SearchTableView.reloadData()
                });
                print(foodItemsArray)
            }
        }
    }

    func USDANutritionRequest(_ foodNdbno:String, foodName:String){
        Client.sharedInstance().getFoodNutrientUSDADatabase(foodNdbno) {(success, nutrientsArray, errorString) in
            if success && nutrientsArray != nil{
                
 
                print(nutrientsArray)
                
                DispatchQueue.main.async {
                    self.nutrientsArray = nutrientsArray!
                    var nutrientArr:[Nutrient] = []
                    for nutrition in nutrientsArray!{
                        let name = nutrition["name"] as? String
                        let unit = nutrition["unit"] as? String
                        guard let measurementsList = nutrition["measures"] as? [[String:AnyObject]] else {
                            print("error parsing measurements")
                            return
                        }
                        let nutrient = Nutrient(nutrientName: name!, unit: unit!)
                        
                        for measurement in measurementsList{
                            //                        let label = measurement["label"] as? String
                            let value = measurement["value"] as? String
                            nutrient.val = value!
                        }
                        
                        
                        nutrientArr.append(nutrient)
                        for nutr in nutrientArr {
                            print(nutr.nutrientName)
                            print(nutr.unit)
                            print(nutr.val)
                        }
                        
                    }
                    let diceRoll = Int(arc4random_uniform(20) + 2)
                    let diceRoll2 = Int(arc4random_uniform(20) + 2)
                    let diceRoll3 = Int(arc4random_uniform(20) + 2)
                    let diceRoll4 = Int(arc4random_uniform(20) + 2)
                    let diceRoll5 = Int(arc4random_uniform(20) + 2)
                    print (CGFloat(Double(diceRoll)/Double(100)))
                    self.energyProgress.progress = (CGFloat(Double(diceRoll)/Double(100)))
                    self.intProgress.progress = (CGFloat(Double(diceRoll2)/Double(100)))
                    self.strengthProgress.progress = (CGFloat(Double(diceRoll3)/Double(100)))
                    self.healthProgress.progress = (CGFloat(Double(diceRoll4)/Double(100)))
                    self.points = diceRoll5
                    self.nutrientPts.text = "\(diceRoll5) Pts"
                    self.nutrientView.animate()
                }
            }
        }

    }

    
    @IBAction func searchClicked(_ sender: AnyObject) {
        USDARequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return foodNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodItemCell")! as UITableViewCell
        cell.textLabel?.text = foodNames[(indexPath as NSIndexPath).row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SearchTableView.deselectRow(at: indexPath, animated: true)
        self.selectedFoodName = foodNames[(indexPath as NSIndexPath).row]
        self.nutrientName.text = selectedFoodName
        self.selectedFoodNdbno = ndbnoList[(indexPath as NSIndexPath).row]
        USDANutritionRequest(self.selectedFoodNdbno!, foodName: self.selectedFoodName! )
    }
    
    @IBAction func cancelPressed(_ sender: AnyObject) {
        nutrientView.animation = "fadeOut"
        nutrientView.animate()
    }
    
    @IBAction func addPressed(_ sender: AnyObject) {
        Singleton.sharedInstance.alertPts = points!
        Singleton.sharedInstance.points += points!
        Singleton.sharedInstance.showAlert = true
        Singleton.sharedInstance.ingredientsList.append(self.nutrientName.text!)
        navigationController?.popViewController(animated: true)
    }


}

