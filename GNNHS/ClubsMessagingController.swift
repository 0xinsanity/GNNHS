//
//  ClubsMessagingController.swift
//  GNNHS
//
//  Created by Noah Hanover on 1/27/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import UIKit
import Parse

class ClubsMessagingController: BasisTableViewController{
    //var layerUser: LYRClient?
    var club_list: [String]!
    var parse_notifications: PFInstallation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parse_notifications = PFInstallation.current()
        
        if (UserDefaults.standard.dictionaryRepresentation().keys.contains("Clubs")) {
            club_list = UserDefaults.standard.value(forKey: "Clubs")! as! [String]
        } else {
            club_list = []
        }
        
        self.navigationController?.navigationBar.topItem!.title = "Club Messaging"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let add_clubs = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(ClubsMessagingController.add_club_to_list))
        
        self.navigationItem.leftBarButtonItem = add_clubs
        
        let suggestions_btn = UIBarButtonItem(title: "President", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ClubsMessagingController.post_as_president))
        
        let font = UIFont(name: "OpenSans", size: 16)
        
        //suggestions_btn.tintColor = UIColor(red: 243/255, green: 119/255, blue: 55/255, alpha: 1)
        suggestions_btn.setTitleTextAttributes([NSFontAttributeName: font!], for: UIControlState())
        
        navigationItem.rightBarButtonItem = suggestions_btn
        
        self.edgesForExtendedLayout = UIRectEdge()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64)
        
        if (UserDefaults.standard.dictionaryRepresentation().keys.contains("Clubs")) {
            club_list = UserDefaults.standard.value(forKey: "Clubs")! as! [String]
            
            for i in club_list {
                parse_notifications.addUniqueObject(i.replacingOccurrences(of: " ", with: "-").replacingOccurrences(of: ".", with: ""), forKey: "channels")
            }
            parse_notifications.saveInBackground()
            
            tableView.reloadData()
        } else {
            club_list = []
        }
        
        
    }
    
    func add_club_to_list() {
            let viewController = UINavigationController(rootViewController: AddClubMessaging())
            viewController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName: UIFont(name: "Expressway", size: 19)!]
            
            viewController.navigationBar.barTintColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
            self.present(viewController, animated: true, completion: nil)
    
    }
    
    func post_as_president() {
        self.navigationController?.pushViewController(PresidentPostController(), animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favorite Clubs"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return club_list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        cell.textLabel?.text = club_list[(indexPath as NSIndexPath).row]
        
        cell = setCellBackgroundText(cell)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            parse_notifications.remove(club_list[(indexPath as NSIndexPath).row].replacingOccurrences(of: " ", with: "-").replacingOccurrences(of: ".", with: ""), forKey: "channels")
            parse_notifications.saveInBackground()
            club_list.remove(at: (indexPath as NSIndexPath).row)
            UserDefaults.standard.set(club_list, forKey: "Clubs")
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(RegularUserMessagesViewController(clicked_club: club_list[(indexPath as NSIndexPath).row]), animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
