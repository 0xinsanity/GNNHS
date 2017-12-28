//
//  RegularUserMessagesViewController.swift
//  GNNHS
//
//  Created by Noah Hanover on 1/28/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import UIKit
import Parse

class RegularUserMessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var current_club: String!
    //var message_board: UILabel!
    //var message_scrollView: UIScrollView!
    var all_texts: [String]! = [String]()
    var tableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    init(clicked_club: String) {
        current_club = clicked_club
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView = UITableView(frame: CGRect(x: 0, y: -20, width: self.view.frame.width, height: self.view.frame.height-20))
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(tableView)
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        recreateMessageBoard()
        tableView.reloadData()
        scrollToBottom()
        self.navigationController?.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64)
    }
    
    func recreateMessageBoard() {
        let query = PFQuery(className: "Alerts")
        query.whereKey("Club", equalTo: current_club)
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
                if (messages != []) {
                    for message in messages {
                        //self.message_board.text = self.message_board.text! + "\(message.objectForKey("Message")!)\n\n"
                        self.all_texts.append(message.object(forKey: "Message") as! String)
                    }
                } else {
                    //self.message_board.text = "Nobody has posted anything yet :("
                    self.all_texts.append("Nobody has posted anything yet :(")
                }
            } catch {
            }
        }
    }
    
    func scrollToBottom() {
        if (tableView.contentSize.height > view.frame.size.height) {
            let ipath: IndexPath = IndexPath(row: 0, section: all_texts.count - 1)
            tableView.scrollToRow(at: ipath, at: .top, animated: true)
        }
    }
    
    
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
