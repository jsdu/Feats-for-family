//
//  File.swift
//  foodhackathon
//
//  Created by JasonDu on 2016-10-29.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import UIKit
import UICircularProgressRing
import SwiftCharts

class ViewController: UIViewController {
    
    @IBOutlet var userIcon: UIImageView!
    
    @IBOutlet var userName: UILabel!
    
    @IBOutlet var userPts: UILabel!
    
    @IBOutlet var sleepProgress: UICircularProgressRingView!
    
    @IBOutlet var stepsProgress: UICircularProgressRingView!
    
    @IBOutlet var foodProgress: UICircularProgressRingView!
    
    @IBOutlet var chartView: UIView!
    
    @IBOutlet var backgroundCardView1: UIView!
    
    @IBOutlet var backgroundCardView2: UIView!
    
    @IBOutlet var backgroundCardView3: UIView!
    
    
    override func viewDidLoad() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animate()
        userPts.text = "\(Singleton.sharedInstance.points) Pts"
        userIcon.image = roundImage(image: userIcon.image!)
        backgroundCardView2.cardView()
        backgroundCardView3.cardView()
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
        )
        
        let chart = BarsChart(
            frame: CGRect(x:-20,y:0, width:398, height:354),
            chartConfig: chartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            bars: [
                ("Jason", 2),
                ("B", 4.5),
                ("C", 3),
                ("D", 5.4)
                
            ],
            color: UIColor(red:0.12, green:0.69, blue:0.61, alpha:1.0),
            barWidth: 40
        )
        
        self.chartView.addSubview(chart.view)
    }
    
    func animate(){
        stepsProgress.animationStyle = kCAMediaTimingFunctionLinear
        
        stepsProgress.setProgress(value: 30, animationDuration: 3.0) {
            print("Done animating!")
            // Do anything your heart desires...
        }
        sleepProgress.setProgress(value: 50, animationDuration: 3.0) {
            print("Done animating!")
            // Do anything your heart desires...
        }
        foodProgress.setProgress(value: 70, animationDuration: 3.0) {
            print("Done animating!")
            // Do anything your heart desires...
        }
        
    }
    
    func roundImage(image:UIImage) -> UIImage
    {
        let newImage = image.copy() as! UIImage
        let cornerRadius = image.size.height/2
        UIGraphicsBeginImageContextWithOptions(image.size, false, 1.0)
        let bounds = CGRect(origin: CGPoint(x: 0,y :0) , size: image.size)
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).addClip()
        newImage.draw(in: bounds)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage!
        
    }


}
