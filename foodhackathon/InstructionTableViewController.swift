//
//  InstructionsViewController.swift
//  RecipeBook
//
//  Created by Austins Work on 10/20/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

import UIKit

class InstuctionTableViewController : UITableViewController{
    var steps : [Steps] = []
    var image: UIImage?
    var name: String?
    var points: String?
    var pts: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.init(red: 180/255, green: 216/255, blue: 231/255, alpha: 1)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count + 1
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! imageCell
            cell.imageHeader.image = self.image
            cell.name.text = self.name
            cell.points.text = self.points
            cell.createButton.addTarget(self, action: #selector(create), for: .touchUpInside)

            return cell
        } else {
        // Create an instance of UITableViewCell, with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionCell",
                                                 for: indexPath) as! InstructionCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let step = steps[(indexPath as NSIndexPath).row-1]
        
        cell.instructionLabel.text = step.step
        
        return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 220
        } else {
            return 109
        }
    }
    
    func create(){
        Singleton.sharedInstance.alertPts = pts!
        Singleton.sharedInstance.points += pts!
        Singleton.sharedInstance.showAlert = true
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}
