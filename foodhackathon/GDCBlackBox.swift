//
//  GDCBlackBox.swift
//  Dialysis Nutrition Tracker
//
//  Created by Steven Chen on 7/1/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
