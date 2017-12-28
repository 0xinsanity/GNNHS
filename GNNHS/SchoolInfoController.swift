//
//  SchoolInfoController.swift
//  GNNHS
//
//  Created by Noah Hanover on 11/3/15.
//  Copyright © 2015 Noah Hanover. All rights reserved.
//

import UIKit

class SchoolInfoController: AEAccordionTableViewController, FUIAlertViewDelegate {
    let array_office = ["Main Office", "Nurse's Office", "Guidance"]
    let tel_office = ["tel:1(516)441-4700", "tel:1(516)441-4710", "tel:1(516)441-4720"]
    
    let array_administration = ["Daniel Holtzman - Principal", "Patricia Hugo - Assistant Principal", "Daniel Krauz - Assistant Principal", "Ronald Levine - Assistant Principal"]
    let tel_administration = ["mailto:dholtzman@greatneck.k12.ny.us", "mailto:phugo@greatneck.k12.ny.us", "mailto:dkrauz@greatneck.k12.ny.us", "mailto:rlevine@greatneck.k12.ny.us"]
    
    let move_bells = ["Ordinary", "Advisory", "Assembly", "2 Hour Delay"]
    let iPhoneHeight = UIScreen.main.bounds.height
    var phone_string: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarHeight = self.tabBarController?.tabBar.bounds.height
        self.edgesForExtendedLayout = UIRectEdge.all
        self.tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: tabBarHeight!, right: 0.0)
        
        self.tableView.backgroundColor = UIColor(red: 243/255, green: 119/255, blue: 55/255, alpha: 1)
    
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            tableView.reloadData()
        }
        self.navigationController?.navigationBar.topItem!.title = "School Info"
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return move_bells.count;
        case 1:
            return array_office.count
        default:
            return array_administration.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Bell Schedules";
        case 1:
            return "Offices - Phone"
        default:
            return "Administration - Email"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell;
        let row_number = (indexPath as NSIndexPath).row
        
        switch (indexPath as NSIndexPath).section {
        case 0:
            let bell_cell = BellScheduleCell()
            
            var time_until_next = 0
            var final_time_string = ""
            
            let date = Date()
            let calendar = Calendar.current
            let current_hour = calendar.component(.hour, from: date)
            let current_minutes = calendar.component(.minute, from: date)
            
            var schedule_hours: [Int]
            var schedule_minutes: [Int]
            
            if (row_number == 0) {
                // Regular
                schedule_hours =   [8, 8, 9, 10,10,11,12,13,13]
                schedule_minutes = [00,44,28,12,56,40,24,08,52]
                
                
                for i in 0...8 {
                    if (current_hour == schedule_hours[i]) {
                        //if (current_minutes > schedule_minutes[i]) {
                        //    continue
                        //}
                        if (current_minutes > schedule_minutes[i] && current_hour == schedule_hours[i+1]) {
                            continue
                        }
                        
                        if (current_minutes < schedule_minutes[i]) {
                            time_until_next = schedule_minutes[i] - current_minutes
                        } else {
                            time_until_next = (schedule_minutes[i+1] + 60) - current_minutes
                        }
                        final_time_string = "\(time_until_next)"
                        break
                    }
                }
                
                if (time_until_next == 0) {
                    if (current_hour <= 24 && current_hour >= 13) {
                        final_time_string = "\(24-current_hour+7) h & \(60-current_minutes)"
                    } else {
                        if (7-current_hour != 0) {
                            final_time_string = "\(7-current_hour) h & \(60-current_minutes)"
                        } else {
                            final_time_string = "\(60-current_minutes)"
                        }
                    }
                }
            } else if (row_number == 1) {
                // Advisory
                schedule_hours =   [8, 8, 9, 9, 10,11,11,12,13,13]
                schedule_minutes = [00,36,16,56,36,16,56,36,16,56]
                
                for i in 0...9 {
                    if (current_hour == schedule_hours[i]) {
                        //if (current_minutes > schedule_minutes[i]) {
                        //    continue
                        //}
                        if (current_minutes > schedule_minutes[i] && current_hour == schedule_hours[i+1]) {
                            continue
                        }
                        
                        if (current_minutes < schedule_minutes[i]) {
                            time_until_next = schedule_minutes[i] - current_minutes
                        } else {
                            time_until_next = (schedule_minutes[i+1] + 60) - current_minutes
                        }
                        final_time_string = "\(time_until_next)"
                        break
                    }
                }
                
                if (time_until_next == 0) {
                    if (current_hour <= 24 && current_hour >= 13) {
                        final_time_string = "\(24-current_hour+7) h & \(60-current_minutes)"
                    } else {
                        if (7-current_hour != 0) {
                            final_time_string = "\(7-current_hour) h & \(60-current_minutes)"
                        } else {
                            final_time_string = "\(60-current_minutes)"
                        }
                    }
                }
                
            } else if (row_number == 2) {
                // Assembly
                schedule_hours =   [8, 8, 9, 10,10,11,12,12,13,13]
                schedule_minutes = [00,39,18,00,42,21,00,39,18,57]
                
                for i in 0...9 {
                    if (current_hour == schedule_hours[i]) {
                        //if (current_minutes > schedule_minutes[i]) {
                        //    continue
                        //}
                        if (current_minutes > schedule_minutes[i] && current_hour == schedule_hours[i+1]) {
                            continue
                        }
                        
                        if (current_minutes < schedule_minutes[i]) {
                            time_until_next = schedule_minutes[i] - current_minutes
                        } else {
                            time_until_next = (schedule_minutes[i+1] + 60) - current_minutes
                        }
                        final_time_string = "\(time_until_next)"
                        break
                    }
                }
                
                if (time_until_next == 0) {
                    if (current_hour <= 24 && current_hour >= 13) {
                        final_time_string = "\(24-current_hour+7) h & \(60-current_minutes)"
                    } else {
                        if (7-current_hour != 0) {
                            final_time_string = "\(7-current_hour) h & \(60-current_minutes)"
                        } else {
                            final_time_string = "\(60-current_minutes)"
                        }
                    }
                }
                
            } else {
                // 2 Hour Delay
                schedule_hours =   [10,10,11,11,12,12,13,13,14]
                schedule_minutes = [00,30,00,30,00,32,04,36,06]
                
                for i in 0...8 {
                    if (current_hour == schedule_hours[i]) {
                        //if (current_minutes > schedule_minutes[i]) {
                        //    continue
                        //}
                        if (current_minutes > schedule_minutes[i] && current_hour == schedule_hours[i+1]) {
                            continue
                        }
                        
                        if (current_minutes < schedule_minutes[i]) {
                            time_until_next = schedule_minutes[i] - current_minutes
                        } else if (i != 8){
                            time_until_next = (schedule_minutes[i+1] + 60) - current_minutes
                        }
                        final_time_string = "\(time_until_next)"
                        break
                    }
                }
                
                if (time_until_next == 0) {
                    if (current_hour <= 24 && current_hour >= 13) {
                        final_time_string = "\(24-current_hour+7) h & \(60-current_minutes)"
                    } else {
                        if (9-current_hour != 0) {
                            final_time_string = "\(9-current_hour) h & \(60-current_minutes)"
                        } else {
                            final_time_string = "\(60-current_minutes)"
                        }
                    }
                }
            }
            
            bell_cell.headerView.text = move_bells[row_number] + " - Next Period Starts: " + final_time_string + " m"
            
            bell_cell.detailView.image = UIImage(named: "schedule\((indexPath as NSIndexPath).row)")
            
            bell_cell.headerView.font = UIFont(name: "OpenSans-Regular", size: 14)
            bell_cell.backgroundColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
            bell_cell.headerView.textColor = UIColor.white
            
            let view = UIView()
            view.backgroundColor = UIColor(red: 14/255, green: 73/255, blue: 168/255, alpha: 1)
            
            bell_cell.selectedBackgroundView = view
            return bell_cell
        case 1:
            cell = UITableViewCell()
            cell.textLabel?.text = array_office[(indexPath as NSIndexPath).row]
            break;
        default:
            cell = UITableViewCell()
            cell.textLabel?.text = array_administration[(indexPath as NSIndexPath).row]
            break;
        }
        
        // Set cell images besides Bells
        cell.textLabel?.font = UIFont(name: "OpenSans", size: 16)
        cell.backgroundColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
        cell.textLabel?.textColor = UIColor.white
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 14/255, green: 73/255, blue: 168/255, alpha: 1)
        
        cell.selectedBackgroundView = view
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor(red: 239/255, green: 136/255, blue: 91/255, alpha: 1)
        
        let sectionLabel = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.bounds.size.width, height: 30))
        
        sectionLabel.textColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
        sectionLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        sectionLabel.font = UIFont(name: "OpenSans-Bold", size: 16)
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            let orientation = UIApplication.shared.statusBarOrientation
            if (orientation == UIInterfaceOrientation.portrait || orientation == UIInterfaceOrientation.portraitUpsideDown) {
                sectionLabel.frame = CGRect(x: 30, y: 0, width: tableView.bounds.size.width, height: 30)
            } else {
                sectionLabel.frame = CGRect(x: 160, y: 0, width: tableView.bounds.size.width, height: 30)
            }
        }
        
        headerView.addSubview(sectionLabel)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var url = NSURL()
        
        switch (indexPath as NSIndexPath).section {
        case 0:
            if let cell = tableView.cellForRow(at: indexPath) as? AEAccordionTableViewCell {
                toggleCell(cell, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            }
            return
        case 1:
            phone_string = tel_office[(indexPath as NSIndexPath).row]
            
            let alertView = FUIAlertView()
            alertView.title = "Call " + array_office[(indexPath as NSIndexPath).row] + "?"
            alertView.addButton(withTitle: "Yes")
            alertView.addButton(withTitle: "No")
            alertView.delegate = self
            alertView.titleLabel!.textColor = UIColor(red: 0.09, green: 0.20, blue: 0.42, alpha: 1.0)
            alertView.titleLabel!.font = UIFont(name: "OpenSans-Bold", size: 16)
            alertView.messageLabel!.textColor = UIColor(red: 0.09, green: 0.20, blue: 0.42, alpha: 1.0)
            alertView.messageLabel!.font = UIFont(name: "OpenSans", size: 14)
            alertView.backgroundOverlay!.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.5)
            alertView.alertContainer!.backgroundColor = UIColor(red: 0.96, green: 0.62, blue: 0.38, alpha: 1.0)
            alertView.defaultButtonColor = UIColor(red: 0.09, green: 0.20, blue: 0.42, alpha: 1.0)
            alertView.defaultButtonShadowColor = UIColor.white
            alertView.defaultButtonFont = UIFont(name: "OpenSans-Bold", size: 16)
            alertView.defaultButtonTitleColor = UIColor.white
            alertView.show()

            
            break;
        default:
            url = NSURL(string: tel_administration[(indexPath as NSIndexPath).row])!
            UIApplication.shared.openURL(url as URL)
            break;
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
            if (iPhoneHeight == 667.0) {
                // iPhone 6
                return expandedIndexPaths.contains(indexPath) ? 450 : 44
            } else if (iPhoneHeight == 736.0) {
                // iPhone 6 Plus
                return expandedIndexPaths.contains(indexPath) ? 500 : 44
            }
            
            return expandedIndexPaths.contains(indexPath) ? 400 : 44
            
        } else {
            return expandedIndexPaths.contains(indexPath) ? 750 : 45
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        tableView.reloadData()
    }
    
    func alertView(_ alertView: FUIAlertView!, didDismissWithButtonIndex buttonIndex: Int) {
        if (buttonIndex == 1) {
            return
        } else {
            let full_url = URL(string: self.phone_string)
            
            UIApplication.shared.openURL(full_url!)
        }
    }
}

