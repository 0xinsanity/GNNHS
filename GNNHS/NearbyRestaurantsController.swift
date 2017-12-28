//
//  SchoolInfoController.swift
//  GNNHS
//
//  Created by Noah Hanover on 11/3/15.
//  Copyright © 2015 Noah Hanover. All rights reserved.
//

import UIKit
import Parse

class NearbyRestaurants: BasisTableViewController, FUIAlertViewDelegate {
    let delivery_array: OrderedDictionary<String, String> = [("Bagel Hut", "tel:(516)482-8939"), ("Chosen Village", "tel:(516)504-1199"), ("Gino's Pizza", "tel:(516)487-1122")]
    let near_campus_array: OrderedDictionary<String, String> = [
        ("27 Dressings", "tel:(516)439-5144"),
        ("Amals", "tel:(516)466-3003"),
        ("Bagel Hut", "tel:(516)482-8939"),
        ("Bevanda", "tel:(516)482-1510"),
        ("Bistro Burger", "tel:(516)321-9260"),
        ("Chipotle", "tel:(516)467-0505"),
        ("Chosen Village", "tel:(516)504-1199"),
        ("Deli on the Green", "tel:(516)487-7440"),
        ("Dunkin' Donuts", "tel:(516)708-9389"),
        ("Entré", "tel:(516)708-9880"),
        ("Everfresh", "tel:(516)773-4600"),
        ("Great Neck Glatt", "tel:(516)773-6328"),
        ("Grill Time", "tel:(516)487-2228"),
        ("Kensington Deli", "tel:(516)487-2410"),
        ("Laverne of Great Neck", "tel:(516)829-8200"),
        ("Mangia Bene", "tel:(516)482-3335"),
        ("Subway", "tel:(516)773-7340"),
        ("Sushi Fusion", "tel:(516)441-5900"),
        ("Sushi Palace", "tel:(516)487-9000"),
        ("Tek-Prime", "tel:(516)466-4224"),
        ("Yummy", "tel:(516)466-8250")]
    var url: NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.topItem!.title = "Nearby Restaurants"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return delivery_array.count
        } else {
            return near_campus_array.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Delivery - Phone"
        } else {
            return "Near Campus - Phone"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if (indexPath as NSIndexPath).section == 0 {
            cell.textLabel?.text = delivery_array.orderedKeys[(indexPath as NSIndexPath).row]
        } else {
            cell.textLabel?.text = near_campus_array.orderedKeys[(indexPath as NSIndexPath).row]
        }
        
        cell = setCellBackgroundText(cell)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertView = FUIAlertView()
        
        if (indexPath as NSIndexPath).section == 0 {
            alertView.title = "Call " + delivery_array.orderedKeys[(indexPath as NSIndexPath).row] + "?"
        } else {
            alertView.title = "Call " + near_campus_array.orderedKeys[(indexPath as NSIndexPath).row] + "?"
        }
        
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
        
        if (indexPath as NSIndexPath).section == 0 {
            url = NSURL(string: delivery_array.orderedValues[(indexPath as NSIndexPath).row])!
        } else {
            url = NSURL(string: near_campus_array.orderedValues[(indexPath as NSIndexPath).row])!
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func alertView(_ alertView: FUIAlertView!, didDismissWithButtonIndex buttonIndex: Int) {
        if (buttonIndex == 1) {
            return
        } else {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
}

