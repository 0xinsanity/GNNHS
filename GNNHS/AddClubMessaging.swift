//
//  AddClubMessaging.swift
//  GNNHS
//
//  Created by Noah Hanover on 1/27/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import UIKit

class AddClubMessaging: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, CustomSearchControllerDelegate, FUIAlertViewDelegate {
    let clubs_list = ["Academic Quiz Bowl", "Action For Womens Health", "Adopt a Dream", "AIDS Awareness Club", "Aid Our Troops", "Animal Rights", "Art Club", "Asian American Society", "American Sign Language Club", "Athletic Leadership", "Backgammon Club", "Baking Club", "Ballet Club", "Best Pals", "Bridges", "C.A.R.E.", "Chamber Music Society", "Chess Team", "Comic Book Club", "Compassion It", "Computer Science Club", "Creations For Donations", "Debate Club", "DECA", "Epiphany", "Everyone United For Africa", "Fashion Club", "Find The Cure", "French Club", "Gay Straight Alliance", "Hebrew Culture Club", "Help the Homeless", "Key Club", "Latin America Culture Club", "Math Team", "Mock Trials", "Model Congress", "Model UN", "Multicultural Activity", "Peer AIDS Education", "Peer Drugs Education", "Piano Club", "Pre-Med Club", "Project Earth", "Robotics", "SADD", "SAVE-Env. Awareness", "Science Olympiads", "Student Book Club", "Table Tennis Club", "Ted-Ed Club", "Teens For Tomorrow", "TriM Music Honor Society"]
    var filtered_clubs = [String]()
    var tableView: UITableView!
    var shouldShowSearchResults = false
    var prettySearchController: PrettySearchBarController!
    var indexPath: Int!
    
    override func viewDidLoad() {
        filtered_clubs = [String]()
        tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        tableView.backgroundColor = UIColor(red: 0.98, green: 0.51, blue: 0.26, alpha: 1)
        self.view.addSubview(tableView)
        
        let cancel_button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(AddClubMessaging.go_back))
        cancel_button.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = cancel_button
        self.navigationController?.navigationBar.topItem!.title = "Select A Club"
        
        //configureSearchController()
        configureCustomSearchController()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
    }
    
    // CONFIGURE THE FUCKING SEARCH BAR
    
    func configureCustomSearchController() {
        prettySearchController = PrettySearchBarController(searchResultsController: self, searchBarFrame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.size.width, height: 50.0), searchBarFont: UIFont(name: "OpenSans", size: 16.0)!, searchBarTextColor: UIColor.white, searchBarTintColor: UIColor(red: 10/255, green: 49/255, blue: 127/255, alpha: 1))
        
        prettySearchController.prettySearchBar.placeholder = "Or just search here..."
        tableView.tableHeaderView = prettySearchController.prettySearchBar
        prettySearchController.customDelegate = self
    }
    
    // SIMPLE SEARCH BAR THINGS
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        prettySearchController.searchBar.resignFirstResponder()
    }
    
    func didStartSearching() {
        shouldShowSearchResults = true
        tableView.reloadData()
    }

    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
    }
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func didChangeSearchText(_ searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        filtered_clubs = clubs_list.filter({ (club) -> Bool in
            let clubText: NSString = club as NSString
            
            return (clubText.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        // Reload the tableview.
        tableView.reloadData()
    }
    
    // UPDATE THE FUCKING RESULTS
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        // Filter the data array and get only those countries that match the search text.
        filtered_clubs = clubs_list.filter({ (club) -> Bool in
            let clubText: NSString = club as NSString
            
            return (clubText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        // Reload the tableview.
        tableView.reloadData()
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (shouldShowSearchResults == true) {
            return filtered_clubs.count
        } else {
            return clubs_list.count
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let club: String
        
        if (shouldShowSearchResults == true) {
            club = filtered_clubs[(indexPath as NSIndexPath).row]
        } else {
            club = clubs_list[(indexPath as NSIndexPath).row]
        }
        cell.textLabel?.text = club
        cell.backgroundColor = UIColor(red: 0.84, green: 0.33, blue: 0.07, alpha: 1)
        
        cell.textLabel?.font = UIFont(name: "OpenSans", size: 16)
        
        cell.textLabel?.textColor = UIColor.white
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.79, green: 0.33, blue: 0.09, alpha: 1)
        
        cell.selectedBackgroundView = view
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        self.indexPath = (indexPath as NSIndexPath).row as Int
        
        let are_you_sure = FUIAlertView()
        are_you_sure.title = "ARE YOU SURE YOU ARE APART OF THIS CLUB?"
        are_you_sure.message = "By subscribing to this club, you will be getting notifications from the club whenever one of the president sends an announcement. Continue by clicking Yes."
        are_you_sure.addButton(withTitle: "YES")
        are_you_sure.addButton(withTitle: "NO")
        are_you_sure.delegate = self
        
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
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func alertView(_ alertView: FUIAlertView!, didDismissWithButtonIndex buttonIndex: Int) {
        if (buttonIndex == 0) {
            var club_list: [String]!
            
            if (UserDefaults.standard.dictionaryRepresentation().keys.contains("Clubs")) {
                club_list = UserDefaults.standard.value(forKey: "Clubs")! as! [String]
            } else {
                club_list = [String]()
            }
            
            if (shouldShowSearchResults == true) {
                club_list.append(filtered_clubs[indexPath])
            } else {
                club_list.append(clubs_list[indexPath])
            }
            
            UserDefaults.standard.set(club_list, forKey: "Clubs")
            
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    func go_back() {
        self.dismiss(animated: true, completion: nil)
    }

}
