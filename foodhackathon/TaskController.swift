//
//  File.swift
//  foodhackathon
//
//  Created by JasonDu on 2016-10-29.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import UIKit
import Fusuma
import Clarifai
import AIFlatSwitch
import ARSLineProgress

class TaskViewController: UIViewController, FusumaDelegate, clarifaiObjectDelegate {

    var foodImage: UIImage?
    var app: ClarifaiApp?
    var searchStr: String?
    var object: clarifaiObject?
    var store: RecipeStore?
    var recipes: [Recipe] = []

    @IBOutlet var action1: AIFlatSwitch!
    
    @IBOutlet var action2: AIFlatSwitch!
    
    @IBOutlet var action3: AIFlatSwitch!
    
    override func viewDidLoad() {
        object = clarifaiObject()
        object?.delegate = self
        store = RecipeStore()
        
        ZAlertView.positiveColor            = UIColor.color("#669999")
        ZAlertView.negativeColor            = UIColor.color("#CC3333")
        ZAlertView.blurredBackground        = true
        ZAlertView.showAnimation            = .bounceRight
        ZAlertView.hideAnimation            = .flyLeft
        ZAlertView.initialSpringVelocity    = 0.3
        ZAlertView.duration                 = 2
        ZAlertView.textFieldTextColor       = UIColor.brown
        ZAlertView.textFieldBackgroundColor = UIColor.color("#EFEFEF")
        ZAlertView.textFieldBorderColor     = UIColor.color("#669999")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (Singleton.sharedInstance.showAlert){
            let dialog = ZAlertView(title: "Success", message: "You have been awarded \(Singleton.sharedInstance.alertPts) Pts", closeButtonText: "Done") { (alertView) in
                alertView.dismissAlertView()
            }
            dialog.allowTouchOutsideToDismiss = false
            dialog.show()
            Singleton.sharedInstance.showAlert = false
        }
    }
    
    @IBAction func takePicture(_ sender: AnyObject) {
        let fusuma = FusumaViewController()
        fusumaTintColor = UIColor(red:0.20, green:0.80, blue:1.00, alpha:1.0)
        fusuma.delegate = self
        fusuma.hasVideo = false // If you want to let the users allow to use video.
        self.present(fusuma, animated: true, completion: nil)
    }
    
    public func fusumaImageSelected(_ image: UIImage) {
        
        print("Image selected")
    }
    
    // Return the image but called after is dismissed.
    public func fusumaDismissedWithImage(_ image: UIImage) {
        
        print("Called just after FusumaViewController is dismissed.")
        ARSLineProgress.show()

        foodImage = image
        object?.recognizeImage(image)

    }
    
    public func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print ("Video Completed")
    }
    
    // When camera roll is not authorized, this method is called.
    public func fusumaCameraRollUnauthorized() {
        
        print("Camera roll unauthorized")
    }
    
    @IBAction func searchClicked(_ sender: AnyObject) {
        self.searchStr = ""
        self.performSegue(withIdentifier: "toSearch", sender: self)
    }

    func performSegue(_ searchStr: String!) {
        ARSLineProgress.hide()

        self.searchStr = searchStr
        self.performSegue(withIdentifier: "toSearch", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get a reference to the second view controller
        if (segue.identifier == "toSearch"){
            let SearchViewController = segue.destination as! SearchViewController
                    SearchViewController.searchStr = searchStr!
        } else if (segue.identifier == "toRecipe"){
            let tableViewController = segue.destination as! IngredientsTableViewController
            tableViewController.recipes = self.recipes
            tableViewController.store = self.store
            tableViewController.instructionStore = InstructionStore()
        }
    }

    @IBAction func recipeClicked(_ sender: AnyObject) {
        store?.fetchRecipes(ingredientList: Singleton.sharedInstance.ingredientsList) {
            (RecipeResult) -> Void in
            
            OperationQueue.main.addOperation {
                
                switch RecipeResult {
                case let .success(RecipeResult):
                    print("Successfully found \(RecipeResult.count) recipes.")
                    for recipe in RecipeResult {
                        print(recipe.id, recipe.title)
                        let found = self.recipes.index {
                            $0.id == recipe.id
                        }
                        
                        if found == nil {
                            self.recipes.append(recipe)
                        }
                    }
                    
                    self.performSegue(withIdentifier: "toRecipe", sender: self)

                case let .failure(error):
                    print("Error fetching recipes: \(error)")
                }
                
            }
            
        }

    }
    
    @IBAction func action1Clicked(_ sender: AnyObject) {
        Singleton.sharedInstance.points += 5
        action1.isUserInteractionEnabled = false
        
        let dialog = ZAlertView(title: "Success", message: "You have been awarded 5 Pts", closeButtonText: "Done") { (alertView) in
            alertView.dismissAlertView()
        }
        dialog.allowTouchOutsideToDismiss = false
       dialog.show()

    }
    
    
    @IBAction func action2Clicked(_ sender: AnyObject) {
        if (sender.tag == 0){
            Singleton.sharedInstance.points += 10
            action2.isUserInteractionEnabled = false
            let dialog = ZAlertView(title: "Success", message: "You have been awarded 10 Pts", closeButtonText: "Done") { (alertView) in
                alertView.dismissAlertView()
            }
            dialog.allowTouchOutsideToDismiss = false
            dialog.show()

        } else {
            Singleton.sharedInstance.points += 13
            action3.isUserInteractionEnabled = false
            let dialog = ZAlertView(title: "Success", message: "You have been awarded 13 Pts", closeButtonText: "Done") { (alertView) in
                alertView.dismissAlertView()
            }
            dialog.allowTouchOutsideToDismiss = false
            dialog.show()
        }
        

    }
    
    
    
    
    
    
}
