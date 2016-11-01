//
//  IngredientCell.swift
//  RecipeBook
//
//  Created by Austins Work on 10/23/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {
    
    @IBOutlet var ingredientLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateWithIngredient(nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        updateWithIngredient(nil)
    }
    func updateWithIngredient(_ ingredient: String?) {
        if let ingredientToDisplay = ingredient {
            ingredientLabel.text = ingredientToDisplay
        }
        else {
            ingredientLabel.text = nil
        }
    }


}
