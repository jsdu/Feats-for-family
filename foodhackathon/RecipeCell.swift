//
//  RecipeCell.swift
//  foodhackathon
//
//  Created by JasonDu on 2016-10-30.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation

//
//  RecipeCell.swift
//  RecipeBook
//
//  Created by Austins Work on 10/18/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell{
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    var pts:Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        updateWithTitle(nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        updateWithTitle(nil)
    }
    
    func updateWithTitle(_ title: String?) {
        if let recipeToDisplay = title {
            titleLabel.text = recipeToDisplay
        }
        else {
            titleLabel.text = nil
        }
    }
     
}
