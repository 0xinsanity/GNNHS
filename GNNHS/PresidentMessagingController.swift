//
//  PresidentMessagingController.swift
//  GNNHS
//
//  Created by Noah Hanover on 1/28/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

class PresidentMessagingController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    //var messagingScrollView: UIScrollView!
    //var messagingLabel: UILabel!
    var all_texts: [String]! = [String]()
    var tableView: UITableView!
    var sendButton: UIButton!
    var typeBar: FUITextField!
    var tabBarHeight: CGFloat!
    let current_user: PFUser! = PFUser.current()
    var the_given_club: String!
    var profile_name: String!
    var kbHeight: CGFloat!
    var cell_height: CGFloat!
    
    init(givenClub: String) {
        the_given_club = givenClub
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.tabBarController?.tabBar.bounds.height != nil) {
            tabBarHeight = (self.tabBarController?.tabBar.bounds.height)!
        } else {
            tabBarHeight = 0;
        }
        
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-tabBarHeight)
        kbHeight = tabBarHeight
        
        tableView = UITableView(frame: CGRect(x: 0, y: -20, width: self.view.frame.width, height: self.view.frame.height-20))
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(tableView)
        setMessagingLabelText()
        
        /*messagingScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-60))
        messagingScrollView.scrollEnabled = true
        self.view.addSubview(messagingScrollView)
        
        messagingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 3000))
        messagingLabel.text = ""
        setMessagingLabelText()
        
        messagingLabel.numberOfLines = 1000
        messagingLabel.sizeToFit()
        messagingScrollView.addSubview(messagingLabel)
        messagingScrollView.contentSize = CGSize(width: messagingLabel.frame.width, height: messagingLabel.frame.height)
        */
        
        sendButton = UIButton(frame: CGRect(x: self.view.frame.width-80, y: self.view.frame.height-40, width: 80, height: 40))
        sendButton.setTitle("Send", for: UIControlState())
        sendButton.setTitleColor(UIColor.blue, for: UIControlState())
        sendButton.setTitleColor(UIColor(red: 0.66, green: 0.67, blue: 0.95, alpha: 1), for: UIControlState.highlighted)
        //sendButton.backgroundColor = UIColor.greenColor()
        sendButton.addTarget(self, action: #selector(PresidentMessagingController.sendInfo), for: UIControlEvents.touchUpInside)
        self.view.addSubview(sendButton)
        
        typeBar = FUITextField(frame: CGRect(x: 0, y: self.view.frame.height-40, width: self.view.frame.width-80, height: 40))
        typeBar.delegate = self
        typeBar.placeholder = "Type a Message"
        typeBar.autocorrectionType = UITextAutocorrectionType.no
        typeBar.font = UIFont(name: "OpenSans", size: 16)
        typeBar.backgroundColor = UIColor.white
        typeBar.edgeInsets = UIEdgeInsetsMake(4.0, 15.0, 4.0, 15.0);
        typeBar.textFieldColor = UIColor.white
        typeBar.borderColor = UIColor.orange
        typeBar.borderWidth = 2.0
        typeBar.cornerRadius = 3.0
        self.view.addSubview(typeBar)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PresidentMessagingController.keyboardFrameWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)

        let tapOutside = UITapGestureRecognizer(target: self, action: #selector(PresidentMessagingController.dismissKeyboard))
        self.tableView.addGestureRecognizer(tapOutside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.all_texts = [String]()
        setMessagingLabelText()
        scrollToBottom()
        navigationController?.navigationBar.topItem?.title = "Messages"
        self.navigationController?.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64)
    }
    
    func setMessagingLabelText() {
        //self.messagingLabel.text = ""
        let query = PFQuery(className: "Alerts")
        query.whereKey("Club", equalTo: the_given_club)
        query.addAscendingOrder("createdAt")
        query.limit = 50
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
                let messages = try query.findObjects()
                for message in messages {
                    //self.messagingLabel.text = self.messagingLabel.text! + "\(message.objectForKey("Message")!)"
                    self.all_texts.append(message.object(forKey: "Message") as! String)
                }
                
                let profile_query = PFQuery(className: "ClubChoice")
                profile_query.whereKey("Username", equalTo: current_user.username!)
                query.addAscendingOrder("createdAt")
                
                let profile_array = try profile_query.findObjects()
                profile_name = profile_array[0]["ProfileName"] as! String
            } catch {
            }
        tableView.reloadData()
    }
    }
    
    func sendInfo() {
        var textWritten = typeBar.text
        
        if (textWritten != "" && textWritten != nil) {
            textWritten = profile_name + ": " + textWritten!
            
            let club_choice = PFObject(className: "Alerts")
            club_choice.setObject(textWritten!, forKey: "Message")
            club_choice.setObject(the_given_club, forKey: "Club")
            club_choice.saveInBackground()
            
            let push = PFPush()
            push.setChannel(the_given_club.replacingOccurrences(of: " ", with: "-").replacingOccurrences(of: ".", with: ""))
            push.setData([
                "alert" : "The president of \(the_given_club) just said: \(textWritten!)",
                "badge" : "Increment"
                ])
            push.sendInBackground()
            
            //self.messagingLabel.text = self.messagingLabel.text! + textWritten!
            self.all_texts.append(textWritten!)
            typeBar.text = ""
            tableView.reloadData()
            
            scrollToBottom()
        } else {
            let are_you_sure = FUIAlertView()
            are_you_sure.title = "YOU DIDN'T TYPE ANYTHING"
            are_you_sure.message = "Please type in a message to send out to the members of this club."
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
        }
        
        //messagingLabel.sizeToFit()
    }
    
    func scrollToBottom() {
        if (tableView.contentSize.height > view.frame.size.height) {
            let ipath: IndexPath = IndexPath(row: 0, section: all_texts.count - 1)
            tableView.scrollToRow(at: ipath, at: .top, animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendInfo()
        return true
    }
    
    // KEYBOARD SHIT
    
    func keyboardFrameWillChange(_ notification: Notification) {
        var keyboardEndFrame: CGRect = (((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey])! as AnyObject).cgRectValue
        keyboardEndFrame.origin.y = keyboardEndFrame.origin.y + kbHeight
        let keyboardBeginFrame: CGRect = (((notification as NSNotification).userInfo![UIKeyboardFrameBeginUserInfoKey])! as AnyObject).cgRectValue
        let animationDuration: TimeInterval = (((notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject)) as! Double
        
        if (kbHeight == tabBarHeight) {
            kbHeight = 0-tabBarHeight
        } else {
            kbHeight = tabBarHeight
        }
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDuration)
        var newFrame: CGRect = self.view.frame
        let keyboardFrameEnd: CGRect = self.view!.convert(keyboardEndFrame, to: nil)
        let keyboardFrameBegin: CGRect = self.view!.convert(keyboardBeginFrame, to: nil)
        newFrame.origin.y -= (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y)
        self.view.frame = newFrame
        UIView.commitAnimations()
        scrollToBottom()
    }
    
    func dismissKeyboard() {
        typeBar.resignFirstResponder()
    }
    
    // TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MessagingTableViewCell()
        
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.font = UIFont(name: "OpenSans", size: 16)
        //cell
        cell.backgroundColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
        //cell.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
        
        cell.textLabel?.textColor = UIColor.white
        //cell.textLabel?.textColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
    
        let view = UIView()
        view.backgroundColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
        
        cell.selectedBackgroundView = view
        
        cell.textLabel?.text = all_texts[(indexPath as NSIndexPath).row+(indexPath as NSIndexPath).section]
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor(red: 243/255, green: 119/255, blue: 55/255, alpha: 1).cgColor
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return all_texts.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
    
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
