//
//  Rewards.swift
//  foodhackathon
//
//  Created by JasonDu on 2016-10-30.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import AIFlatSwitch
class RewardsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var ptsLabel: UILabel!
    var rewards:[String] = ["Square Bar (20 Pts)", "Lunch Bundle (30 Pts)"]
    var rewardName:[String] = ["Square Bar","Lunch Bundle"]
    var imageStr:[String] = ["squareBar","revolution"]
    var pts:[Int] = [20,30]
    
    override func viewDidAppear(_ animated: Bool) {
        ptsLabel.text = "\(Singleton.sharedInstance.points) Pts"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return rewards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell")! as! RewardCell
        cell.rewardButton.addTarget(self, action: #selector(reward), for: .touchUpInside)
        cell.rewardButton.tag = indexPath.row
        cell.rewardImage.image = UIImage(named: imageStr[indexPath.row])
        cell.rewardLabel.text = rewards[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func reward(sender:AIFlatSwitch){
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
        
        if (pts[sender.tag] <= Singleton.sharedInstance.points){
        Singleton.sharedInstance.points -= pts[sender.tag]
        sender.isUserInteractionEnabled = false
        

        let dialog = ZAlertView(title: "Success", message: "You have redeemed \(rewardName[sender.tag]).", closeButtonText: "Done") { (alertView) in
            alertView.dismissAlertView()
        }
        dialog.allowTouchOutsideToDismiss = false
        dialog.show()
        ptsLabel.text = "\(Singleton.sharedInstance.points) Pts"
        } else {
            let dialog = ZAlertView(title: "Failed", message: "Not enough points", closeButtonText: "Done") { (alertView) in
                alertView.dismissAlertView()
            }
            dialog.allowTouchOutsideToDismiss = false
            dialog.show()
        }
        
    }
    
    
    
}
