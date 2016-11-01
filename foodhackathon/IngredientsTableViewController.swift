//
//  IngredientsTableViewController.swift
//  RecipeBook
//
//  Created by Austins Work on 10/18/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

import UIKit

class IngredientsTableViewController: UITableViewController {
    
    var recipes: [Recipe] = []
    var recipeImages : [Int:UIImage] = [:]
    var recipe : Recipe!
    var store: RecipeStore!
    var instructionStore : InstructionStore!
    var imageStore = ImageStore()
    var steps: [Steps] = []
    var recipeTitle : String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.init(red: 180/255, green: 216/255, blue: 231/255, alpha: 1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for recipe in recipes{
            self.store.fetchImageForRecipe(recipe, completion: { (result) -> Void in
                
                
                switch result{
                case let .success(image):
                    self.recipeImages.updateValue(image, forKey: recipe.id)
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                    print("🔥🔥🔥We got image🔥🔥🔥")
                    
                case let .failure(error):
                    print("🔥🔥🔥Error with fetching errors🔥🔥🔥")
                }
                
            })
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        
        let recipe = recipes[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as! RecipeCell
        cell.titleLabel?.text = recipe.title
//        if recipeImages.keys.contains(recipe.id) {
//            cell.imageView?.image = recipeImages[recipe.id]
//        }
//        cell.backgroundColor = UIColor.init(red: 180/255, green: 216/255, blue: 231/255, alpha: 1)
        let diceRoll = Int(arc4random_uniform(10) + 5)
        cell.pts = diceRoll
        cell.pointsLabel.text = "\(diceRoll) Pts"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for recipe in self.recipes{
            let recipeCell = tableView.cellForRow(at: indexPath) as! RecipeCell
            if recipe.title == recipeCell.titleLabel?.text{
                var id = recipe.id
                self.instructionStore.fetchInstructions(id: id){
                    (AnalyzedInstructionResult) -> Void in
                    switch AnalyzedInstructionResult{
                    case let .success(AnalyzedInstructionResult):
                        print("Successfully found \(AnalyzedInstructionResult.count) recipes.")
                        for step in AnalyzedInstructionResult{
                            self.steps.append(step)
                            print(step.step)
                        }
                        OperationQueue.main.addOperation {
                            var newImage = UIImage()
                            if (self.recipeImages[id] != nil) {
                                newImage = self.recipeImages[id]!
                            }
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let recipeInstructionViewController = storyboard.instantiateViewController(withIdentifier: "InstructionTableViewController") as! InstuctionTableViewController
                            recipeInstructionViewController.steps = self.steps
                            recipeInstructionViewController.image = newImage
                            recipeInstructionViewController.name = recipe.title
                            recipeInstructionViewController.points = recipeCell.pointsLabel.text
                            recipeInstructionViewController.pts = recipeCell.pts
                            self.show(recipeInstructionViewController, sender: self)
                        }
                    case let .failure(error):
                        print("Error fetching steps: \(error)")
                    }
                }
                
            }else {
                print("🔥🔥🔥Not The Recipe You Are Looking For🔥🔥🔥")
            }
            print("🔥🔥🔥Finished IF Statement🔥🔥🔥")
        }
        print("🔥🔥🔥\(tableView.cellForRow(at: indexPath)?.textLabel?.text)🔥🔥🔥")
    }
    
    
}
