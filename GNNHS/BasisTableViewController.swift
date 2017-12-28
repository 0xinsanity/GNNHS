//
//  BasisTableViewController.swift
//  GNNHS
//
//  Created by Noah Hanover on 11/6/15.
//  Copyright © 2015 Noah Hanover. All rights reserved.
//

import UIKit

class BasisTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tabBarHeight: CGFloat
        
        if (self.tabBarController?.tabBar.bounds.height != nil) {
            tabBarHeight = (self.tabBarController?.tabBar.bounds.height)!
        } else {
            tabBarHeight = 0;
        }
        
        self.tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: tabBarHeight, right: 0.0)
        self.tableView.backgroundColor = UIColor(red: 243/255, green: 119/255, blue: 55/255, alpha: 1)
        //self.tableView.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            tableView.reloadData()
        }
        self.navigationController?.isNavigationBarHidden = false
        super.viewDidAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    
    func setCellBackgroundText(_ cell: UITableViewCell) -> UITableViewCell {
        
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
    
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        tableView.reloadData()
    }
}
