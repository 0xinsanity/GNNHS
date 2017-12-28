//
//  ViewController.swift
//  GNNHS
//
//  Created by Noah Hanover on 11/3/15.
//  Copyright © 2015 Noah Hanover. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {
    let WIDTH = UIScreen.main.bounds.width
    //public let HEIGHT = UIScreen.mainScreen().bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let suggestions_btn = UIBarButtonItem(title: "Suggest", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MainTabBar.email_me))
        suggestions_btn.tintColor = UIColor.white
        
        let font = UIFont(name: "OpenSans", size: 16)
        
        //suggestions_btn.tintColor = UIColor(red: 243/255, green: 119/255, blue: 55/255, alpha: 1)
        suggestions_btn.setTitleTextAttributes([NSFontAttributeName: font!], for: UIControlState())
        
        navigationItem.rightBarButtonItem = suggestions_btn
        
        self.edgesForExtendedLayout = UIRectEdge()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title! {
        case "Club Messaging":
            tabBar.items![1].badgeValue = nil
            break;
        default:
            break;
        }
    }
    
    func email_me() {
        let url = URL(string: "mailto:noahsahar@gmail.com")!
        
        UIApplication.shared.openURL(url)
    }
    


}

