//
//  PresidentPostingController.swift
//  GNNHS
//
//  Created by Noah Hanover on 1/27/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

class PresidentPostController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    var loginButton: FUIButton!
    var questionLabel: UILabel!
    var pick_club: UIPickerView!
    let club_datasource = AddClubMessaging().clubs_list
    var current_user = PFUser.current()
    var tableView: UITableView!
    var club_choice: [String]!
    let parse_installations = PFInstallation.current()
    var background_view: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect(x: 0, y: -20, width: self.view.frame.width, height: self.view.frame.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 243/255, green: 119/255, blue: 55/255, alpha: 1)
        self.view.addSubview(tableView)
        
        questionLabel = UILabel(frame: CGRect(x: 10, y: 30, width: self.view.frame.width-20, height: 150))
        questionLabel.text = "Pick which club you are the president of, and we will review you to make sure you are not lying!"
        questionLabel.textColor = UIColor.white
        questionLabel.font = UIFont(name: "OpenSans-Bold", size: 16)
        questionLabel.textAlignment = NSTextAlignment.center
        questionLabel.numberOfLines = 3
        
        background_view = UIView(frame: self.view.frame)
        background_view.backgroundColor = UIColor(red: 239/255, green: 136/255, blue: 91/255, alpha: 1)
        
        pick_club = UIPickerView(frame: CGRect(x: 10, y: 60, width: self.view.frame.width-20, height: 460))
        pick_club.delegate = self
        pick_club.dataSource = self
        pick_club.selectRow(5, inComponent: 0, animated: false)
        
        loginButton = FUIButton(frame: CGRect(x: self.view.frame.midX-125, y: 480, width: 250, height: 45))
        loginButton.addTarget(self, action: #selector(PresidentPostController.login_with_facebook), for: UIControlEvents.touchUpInside)
        loginButton.setTitle("QUALIFY FOR PRESIDENCY", for: UIControlState())
        loginButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 16)
        loginButton.tintColor = UIColor.white
        loginButton.buttonColor = UIColor.blue
        loginButton.shadowHeight = 3.0
        loginButton.cornerRadius = 6.0
        loginButton.shadowColor = UIColor(red: 0.77, green: 0.33, blue: 0.02, alpha: 1)
        loginButton.titleLabel?.textAlignment = NSTextAlignment.center
        //addButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        self.view.addSubview(background_view)
        self.view.addSubview(pick_club)
        self.view.addSubview(questionLabel)
        self.view.addSubview(loginButton)
        
        if current_user != nil {
            club_choice = [String]()
            //reloadClubChoice()
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(PresidentPostController.add_another_presidency))
            self.pick_club.isHidden = true
            self.loginButton.isHidden = true
            self.questionLabel.isHidden = true
            self.background_view.isHidden = true
        } else {
            self.tableView.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64)
        if (current_user != nil) {
            club_choice = [String]()
            reloadClubChoice()
        }
        tableView.reloadData()
    }
    
    func login_with_facebook() {
        // TODO: IMPLEMENT FALSE ATTRIBUTE
        
        club_choice = [String]()
        PFFacebookUtils.logInInBackground(withReadPermissions: ["public_profile"]) { (user, error) -> Void in
            if let user = user {
                    FBSDKGraphRequest.init(graphPath: "me", parameters: nil).start(completionHandler: { (connection, result, error) -> Void in
                        let club_choice = PFObject(className: "ClubChoice")
                        club_choice.setObject(false, forKey: "Accepted")
                        club_choice.setObject(self.club_datasource[self.pick_club.selectedRow(inComponent: 0)], forKey: "Club")
                        club_choice.setObject(user.username!, forKey: "Username")
                        club_choice.setObject((result as! NSDictionary).object(forKey: "name") as! String, forKey: "ProfileName")
                        club_choice.saveInBackground()
                        
                        self.current_user = user
                        if user.isNew {
                            self.reloadClubChoice()
                        } else {
                            self.club_choice.append(self.club_datasource[self.pick_club.selectedRow(inComponent: 0)] + ": Not Accepted Yet")
                        }
                        self.tableView.reloadData()
                    })
                
                self.pick_club.isHidden = true
                self.questionLabel.isHidden = true
                self.loginButton.isHidden = true
                self.background_view.isHidden = true
                
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(PresidentPostController.add_another_presidency))
                self.tableView.isHidden = false
            }
        }
    }
    
    func reloadClubChoice() {
        // TODO: IMPLEMENT FALSE ATTRIBUTE
        
        let query = PFQuery(className: "ClubChoice")
        query.whereKey("Username", equalTo: (current_user?.username)!)
        query.addAscendingOrder("createdAt")
        
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
            do {
                let clubs = try query.findObjects()
                for club in clubs {
                    if (club["Accepted"] as! Bool == false) {
                        self.club_choice.append(club["Club"] as! String + ": Not Accepted Yet")
                    } else {
                        self.club_choice.append(club["Club"] as! String)
                    }
                    self.parse_installations.addUniqueObject(("President-\(club["Club"] as! String)").replacingOccurrences(of: " ", with: "-"), forKey: "channels")
                    self.parse_installations.saveInBackground()
                }
            } catch {
            }
        }
        
    }

    // UIPICKERVIEW
    
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
    
    // TABLEVIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (current_user != nil){
            return club_choice.count
        }
        else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = club_choice[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.font = UIFont(name: "OpenSans", size: 16)
        //cell
        cell.backgroundColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
        //cell.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
        
        cell.textLabel?.textColor = UIColor.white
        //cell.textLabel?.textColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 14/255, green: 73/255, blue: 168/255, alpha: 1)
        
        cell.selectedBackgroundView = view
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Presidency Section - Clubs"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (club_choice[(indexPath as NSIndexPath).row].range(of: ": Not Accepted Yet") == nil) {
            self.navigationController?.pushViewController(PresidentMessagingController(givenClub: club_choice[(indexPath as NSIndexPath).row]), animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let query = PFQuery(className: "ClubChoice")
            query.whereKey("Username", equalTo: (current_user?.username)!)
            query.addAscendingOrder("createdAt")
            
            query.findObjectsInBackground(block: { (clubs, error) -> Void in
                if error == nil && clubs != nil {
                    clubs![(indexPath as NSIndexPath).row].deleteInBackground()
                } else {
                    print(error)
                }
            })
            club_choice.remove(at: (indexPath as NSIndexPath).row)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor(red: 239/255, green: 136/255, blue: 91/255, alpha: 1)
        
        let sectionLabel = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.bounds.size.width, height: 30))
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            let orientation = UIApplication.shared.statusBarOrientation
            if (orientation == UIInterfaceOrientation.portrait || orientation == UIInterfaceOrientation.portraitUpsideDown) {
                sectionLabel.frame = CGRect(x: 30, y: 0, width: tableView.bounds.size.width, height: 30)
            } else {
                sectionLabel.frame = CGRect(x: 160, y: 0, width: tableView.bounds.size.width, height: 30)
            }
        }
        
        sectionLabel.textColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
        sectionLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        sectionLabel.font = UIFont(name: "OpenSans-Bold", size: 16)
        
        headerView.addSubview(sectionLabel)
        return headerView
    }
    
    func add_another_presidency() {
        let viewController = UINavigationController(rootViewController: AddPresidentClubController())
        viewController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "Expressway", size: 19)!]
        
        viewController.navigationBar.barTintColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        tableView.frame = CGRect(x: 0, y: -20, width: self.view.frame.width, height: self.view.frame.height)
        tableView.reloadData()
    }
    
}
