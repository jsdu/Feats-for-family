//
//  CardView.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func cardView() {
        self.layer.cornerRadius = 3.0
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.8
    }
    
    func cellView() {
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.8
    }
}
