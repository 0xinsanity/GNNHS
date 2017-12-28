//
//  AddPresidentClub.swift
//  GNNHS
//
//  Created by Noah Hanover on 1/28/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import UIKit
import Parse

class AddPresidentClubController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, FUIAlertViewDelegate {
    let current_user = PFUser.current()
    var pick_club: UIPickerView!
    let club_datasource = AddClubMessaging().clubs_list
    var addButton: FUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background_view = UIView(frame: self.view.frame)
        background_view.backgroundColor = UIColor(red: 239/255, green: 136/255, blue: 91/255, alpha: 1)
        self.view.addSubview(background_view)
        
        pick_club = UIPickerView(frame: CGRect(x: 10, y: -20, width: self.view.frame.width-20, height: 500))
        pick_club.delegate = self
        pick_club.dataSource = self
        pick_club.selectRow(5, inComponent: 0, animated: false)
        self.view.addSubview(pick_club)
        
        addButton = FUIButton(frame: CGRect(x: self.view.frame.midX-125, y: 480, width: 250, height: 45))
        addButton.addTarget(self, action: #selector(AddPresidentClubController.add_another_club), for: UIControlEvents.touchUpInside)
        addButton.setTitle("QUALIFY FOR ANOTHER CLUB", for: UIControlState())
        addButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 16)
        addButton.tintColor = UIColor.white
        addButton.buttonColor = UIColor.blue
        addButton.shadowHeight = 3.0
        addButton.cornerRadius = 6.0
        addButton.shadowColor = UIColor(red: 0.77, green: 0.33, blue: 0.02, alpha: 1)
        addButton.titleLabel?.textAlignment = NSTextAlignment.center
        //addButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.view.addSubview(addButton)
        
        let cancel_button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(AddPresidentClubController.go_back))
        cancel_button.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = cancel_button
        self.navigationController?.navigationBar.topItem!.title = "Add Presidency Club"
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return club_datasource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return club_datasource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = club_datasource[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "OpenSans", size: 25.0)!,NSForegroundColorAttributeName:UIColor.white])
        pickerLabel.attributedText = myTitle
        //if (pick_club.selectedRowInComponent(0) = row) {
         //   pickerLabel.backgroundColor = UIColor.orangeColor()
        //} else {
            pickerLabel.backgroundColor = UIColor.blue
        //}
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    func add_another_club() {
        let are_you_sure = FUIAlertView()
        are_you_sure.title = "ARE YOU SURE?"
        are_you_sure.message = "Please press yes if you are the president of the club. If not, press no. If you did click yes by accident, you can still swipe to delete the club later."
        are_you_sure.addButton(withTitle: "YES")
        are_you_sure.addButton(withTitle: "NO")
        are_you_sure.delegate = self
        
        are_you_sure.titleLabel!.textColor = UIColor(red: 0.09, green: 0.20, blue: 0.42, alpha: 1.0)
        are_you_sure.titleLabel!.font = UIFont(name: "OpenSans-Bold", size: 16)
        are_you_sure.messageLabel!.textColor = UIColor(red: 0.09, green: 0.20, blue: 0.42, alpha: 1.0)
        are_you_sure.messageLabel!.font = UIFont(name: "OpenSans", size: 14)
        are_you_sure.backgroundOverlay!.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.5)
        are_you_sure.alertContainer!.backgroundColor = UIColor(red: 0.96, green: 0.62, blue: 0.38, alpha: 1.0)
        are_you_sure.defaultButtonColor = UIColor(red: 0.09, green: 0.20, blue: 0.42, alpha: 1.0)
        are_you_sure.defaultButtonShadowColor = UIColor.white
        are_you_sure.defaultButtonFont = UIFont(name: "OpenSans-Bold", size: 16)
        are_you_sure.defaultButtonTitleColor = UIColor.white
        are_you_sure.show()
    }
    
    func alertView(_ alertView: FUIAlertView!, didDismissWithButtonIndex buttonIndex: Int) {
        
        if (buttonIndex == 0) {
            if (Reachability()?.currentReachabilityStatus == Reachability.NetworkStatus.notReachable) {
                let are_you_sure = FUIAlertView()
                are_you_sure.title = "SOMETHING WENT WRONG"
                are_you_sure.message = "Please check to make sure that you are connected to the internet. To reload page, go back to the previous view and come back."
                are_you_sure.addButton(withTitle: "OK")
                
                are_you_sure.titleLabel!.textColor = UIColor(red: 0.09, green: 0.20, blue: 0.42, alpha: 1.0)
                are_you_sure.titleLabel!.font = UIFont(name: "OpenSans-Bold", size: 16)
                are_you_sure.messageLabel!.textColor = UIColor(red: 0.09, green: 0.20, blue: 0.42, alpha: 1.0)
                are_you_sure.messageLabel!.font = UIFont(name: "OpenSans", size: 14)
                are_you_sure.backgroundOverlay!.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.5)
                are_you_sure.alertContainer!.backgroundColor = UIColor(red: 0.96, green: 0.62, blue: 0.38, alpha: 1.0)
                are_you_sure.defaultButtonColor = UIColor(red: 0.09, green: 0.20, blue: 0.42, alpha: 1.0)
                are_you_sure.defaultButtonShadowColor = UIColor.white
                are_you_sure.defaultButtonFont = UIFont(name: "OpenSans-Bold", size: 16)
                are_you_sure.defaultButtonTitleColor = UIColor.white
                are_you_sure.show()
            } else {
                FBSDKGraphRequest.init(graphPath: "me", parameters: nil).start(completionHandler: {(connection, result, error) -> Void in
                    let club_choice = PFObject(className: "ClubChoice")
                    club_choice.setObject(false, forKey: "Accepted")
                    club_choice.setObject(self.club_datasource[self.pick_club.selectedRow(inComponent: 0)], forKey: "Club")
                    club_choice.setObject(self.current_user!.username!, forKey: "Username")
                    club_choice.setObject((result as! NSDictionary).object(forKey: "name") as! String, forKey: "ProfileName")
                    club_choice.saveInBackground()
                })
            }
        }
            self.dismiss(animated: true, completion: nil)
        }
    
    func go_back() {
        self.dismiss(animated: true, completion: nil)
    }
}
