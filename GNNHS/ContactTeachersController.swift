//
//  SchoolInfoController.swift
//  GNNHS
//
//  Created by Noah Hanover on 11/3/15.
//  Copyright © 2015 Noah Hanover. All rights reserved.
//

import UIKit

class ContactTeachersController: BasisTableViewController {
    var teacher_departments = ["Guidance", "Mathematics", "Science", "English", "Social Studies", "Foreign Language", "Study Skills", "Business", "ESL", "Fine & Performing Arts", "Special Education", "Health", "Physical Education"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teacher_departments = teacher_departments.sorted()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.topItem!.title = "Contact Teachers"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teacher_departments.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Departments - Email"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        cell.textLabel?.text = teacher_departments[(indexPath as NSIndexPath).row]
        
        cell = setCellBackgroundText(cell)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subject_controller = SubjectActivityController(subject: SubjectActivityController.subject_type(rawValue: (indexPath as NSIndexPath).row)!)
        
        navigationController?.pushViewController(subject_controller, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
}

