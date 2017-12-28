//
//  BellScheduleController.swift
//  GNNHS
//
//  Created by Noah Hanover on 11/3/15.
//  Copyright © 2015 Noah Hanover. All rights reserved.
//

import UIKit

class BellScheduleController: AEAccordionTableViewController {
    
    let array_schedules = ["Ordinary", "Advisory", "Assembly"]
    let iPhoneHeight = UIScreen.mainScreen().bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarHeight = self.tabBarController?.tabBar.bounds.height
        self.edgesForExtendedLayout = UIRectEdge.All
        self.tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: tabBarHeight!, right: 0.0)
        
        self.tableView.backgroundColor = UIColor(red: 243/255, green: 119/255, blue: 55/255, alpha: 1)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.topItem!.title = "Bell Schedules"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array_schedules.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Bell Schedule Times"
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor(red: 239/255, green: 136/255, blue: 91/255, alpha: 1)
        
        let sectionLabel = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.bounds.size.width, height: 30))
        
        sectionLabel.textColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
        sectionLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        sectionLabel.font = UIFont(name: "OpenSans-Bold", size: 16)
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad) {
            sectionLabel.frame = CGRect(x: 30, y: 0, width: tableView.bounds.size.width, height: 30)
        }
        
        headerView.addSubview(sectionLabel)
        return headerView
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = BellScheduleCell()
        
        cell.headerView.text = array_schedules[indexPath.row]
        
        cell.detailView.image = UIImage(named: "schedule\(indexPath.row)")
        
        cell.headerView.font = UIFont(name: "OpenSans-Regular", size: 14)
        cell.backgroundColor = UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1)
        cell.headerView.textColor = UIColor.whiteColor()
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 14/255, green: 73/255, blue: 168/255, alpha: 1)
        
        cell.selectedBackgroundView = view
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Phone) {
            if (iPhoneHeight == 667.0) {
                // iPhone 6
                return expandedIndexPaths.contains(indexPath) ? 450 : 44
            } else if (iPhoneHeight == 736.0) {
                // iPhone 6 Plus
                return expandedIndexPaths.contains(indexPath) ? 500 : 44
            }

            return expandedIndexPaths.contains(indexPath) ? 400 : 44
            
        } else {
            return expandedIndexPaths.contains(indexPath) ? 745 : 45
        }
    }
}