//
//  SchoolInfoController.swift
//  GNNHS
//
//  Created by Noah Hanover on 11/3/15.
//  Copyright © 2015 Noah Hanover. All rights reserved.
//

import UIKit

class ResourcesController: BasisTableViewController {
    let dic_website_names: OrderedDictionary<String, String> = [
        ("Athletics", "http://www.guidepostonline.org/sports-center/"),
        ("Canvas", "http://canvas.instructure.com"),
        ("Calendar", "http://www.greatnecknorthhspto.weebly.com/calendar.html"),
        ("Edmodo", "http://www.edmodo.com"),
        ("GNPS Website", "http://www.greatneck.k12.ny.us"),
        ("Google Classroom", "http://www.classroom.google.com"),
        ("Guide Post Online", "http://www,guidepostonline.org/"),
        ("IC Parent Portal", "http://www.ic.greatneck.k12.ny.us"),
        ("IC Teacher Portal", "http://www.ic.greatneck.k12.ny.us"),
        ("Late Bus Schedule", "http://gnnhshomepage.weebly.com/uploads/5/9/7/8/59789245/late_bus_schedule.pdf"),
        ("Learnedness", "http://www.learnedness.net"),
        ("Naviance", "http://www.naviance.com/#"),
        ("School Website", "http://www.greatneck.k12.ny.us/GNPS/NHS/index.html"),
        ("Turnitin", "http://www.turnitin.com")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.topItem!.title = "Websites"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dic_website_names.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Important Websites"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = BellScheduleCell()
        
        cell.textLabel?.text = dic_website_names.orderedKeys[(indexPath as NSIndexPath).row]
        cell = setCellBackgroundText(cell) as! BellScheduleCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: dic_website_names.orderedValues[(indexPath as NSIndexPath).row])!
        
        UIApplication.shared.openURL(url)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

