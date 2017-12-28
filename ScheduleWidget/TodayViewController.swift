//
//  TodayViewController.swift
//  ScheduleWidget
//
//  Created by Noah Hanover on 10/7/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import UIKit
import NotificationCenter

//@objc(TodayViewController)

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var schedule_array: [String]!
    var schedule_img: UIImageView!
    var ordinary_button: UIButton!
    var advisory_button: UIButton!
    var assembly_button: UIButton!
    var twohour_button: UIButton!
    var return_to_fullsize: UIButton!
    let iPhoneHeight = UIScreen.main.bounds.height
    var content_size: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schedule_array = ["Ordinary", "Advisory", "Assembly", "2 Hour Delay"]
        
        if #available(iOSApplicationExtension 10.0, *) {
            self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
            
            return_to_fullsize = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 110))
            return_to_fullsize.alpha = 0.0
            return_to_fullsize.setTitle("Please Return To Full Size\nOr Click To Go To App", for: UIControlState.normal)
            return_to_fullsize.titleLabel?.numberOfLines = 2
            return_to_fullsize.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            return_to_fullsize.setTitleColor(UIColor.black, for: UIControlState.normal)
            return_to_fullsize.titleLabel?.textAlignment = NSTextAlignment.center
            return_to_fullsize.contentVerticalAlignment = UIControlContentVerticalAlignment.center
            return_to_fullsize.addTarget(self, action: #selector(go_to_app), for: UIControlEvents.touchDown)
            self.view.addSubview(return_to_fullsize)
        } else {
            self.preferredContentSize = CGSize(width: self.preferredContentSize.width, height: 425)
        }
        
        var x_ordinary: Int
        var x_advisory: Int
        var x_assembly: Int
        var y_schedule: Int
        var schedule_height: Int
        if (iPhoneHeight == 667.0) {
            // Regular 6, 6s, 7
            
            content_size = 425
            x_ordinary = 25
            x_advisory = 135
            x_assembly = 240
            y_schedule = 60
            schedule_height = 375
        } else if (iPhoneHeight == 736.0) {
            // iPhone 6+, 6s+, 7+
            content_size = 467
            
            x_ordinary = 50
            x_advisory = 160
            x_assembly = 270
            y_schedule = 60
            
            if (Double(UIDevice.current.systemVersion)! < 10.0) {
                schedule_height = 375
            } else {
                schedule_height = 410
            }
            
        } else {
            // iPhone 5, 5s, SE
            
            content_size = 390
            x_ordinary = 10
            x_advisory = 110
            x_assembly = 200
            y_schedule = 40
            schedule_height = 375
        }
        
        ordinary_button = UIButton(frame: CGRect(x: x_ordinary, y: 0, width: 85, height: 28))
        ordinary_button.setTitle(schedule_array[0], for: UIControlState.normal)
        ordinary_button.titleLabel?.textAlignment = NSTextAlignment.center
        ordinary_button.backgroundColor = UIColor.blue
        ordinary_button.layer.cornerRadius = 6
        ordinary_button.addTarget(self, action: #selector(ordinary_click), for: UIControlEvents.touchDown)
        self.view.addSubview(ordinary_button)
        
        advisory_button = UIButton(frame: CGRect(x: x_advisory, y: 0, width: 85, height: 28))
        advisory_button.setTitle(schedule_array[1], for: UIControlState.normal)
        advisory_button.titleLabel?.textAlignment = NSTextAlignment.center
        advisory_button.layer.cornerRadius = 6
        advisory_button.addTarget(self, action: #selector(advisory_click), for: UIControlEvents.touchDown)
        self.view.addSubview(advisory_button)
        
        assembly_button = UIButton(frame: CGRect(x: x_assembly, y: 0, width: 90, height: 28))
        assembly_button.setTitle(schedule_array[2], for: UIControlState.normal)
        assembly_button.titleLabel?.textAlignment = NSTextAlignment.center
        assembly_button.addTarget(self, action: #selector(assembly_click), for: UIControlEvents.touchDown)
        assembly_button.layer.cornerRadius = 6
        self.view.addSubview(assembly_button)
        
        twohour_button = UIButton(frame: CGRect(x: x_advisory-25, y: 30, width: 125, height: 28))
        twohour_button.setTitle(schedule_array[3], for: UIControlState.normal)
        twohour_button.titleLabel?.textAlignment = NSTextAlignment.center
        twohour_button.addTarget(self, action: #selector(twohour_click), for: UIControlEvents.touchDown)
        twohour_button.layer.cornerRadius = 6
        self.view.addSubview(twohour_button)
        
        schedule_img = UIImageView(frame: CGRect(x: -7, y: y_schedule, width: Int(self.view.frame.width), height: schedule_height-10))
        schedule_img.image = UIImage(named: "schedule0")
        schedule_img.contentMode = UIViewContentMode.scaleAspectFit
        self.view.addSubview(schedule_img)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if (activeDisplayMode == NCWidgetDisplayMode.compact) {
            self.preferredContentSize = maxSize
            went_to_bad_size()
        }
        else {
            self.preferredContentSize = CGSize(width: 0, height: content_size)
            went_to_right_size()
        }
    }
    
    func went_to_bad_size() {
        return_to_fullsize.alpha = 1.0
        ordinary_button.alpha = 0.0
        advisory_button.alpha = 0.0
        assembly_button.alpha = 0.0
        twohour_button.alpha = 0.0
        schedule_img.alpha = 0.0
    }
    
    func went_to_right_size() {
        return_to_fullsize.alpha = 0.0
        ordinary_button.alpha = 1.0
        advisory_button.alpha = 1.0
        assembly_button.alpha = 1.0
        twohour_button.alpha = 1.0
        schedule_img.alpha = 1.0
    }
    
    func ordinary_click() {
        schedule_img.image = UIImage(named: "schedule0")
        ordinary_button.backgroundColor = UIColor.blue
        advisory_button.backgroundColor = UIColor.clear
        assembly_button.backgroundColor = UIColor.clear
        twohour_button.backgroundColor = UIColor.clear
    }
    
    func advisory_click() {
        schedule_img.image = UIImage(named: "schedule1")
        ordinary_button.backgroundColor = UIColor.clear
        advisory_button.backgroundColor = UIColor.blue
        assembly_button.backgroundColor = UIColor.clear
        twohour_button.backgroundColor = UIColor.clear
    }
    
    func assembly_click() {
        schedule_img.image = UIImage(named: "schedule2")
        ordinary_button.backgroundColor = UIColor.clear
        advisory_button.backgroundColor = UIColor.clear
        assembly_button.backgroundColor = UIColor.blue
        twohour_button.backgroundColor = UIColor.clear
    }
    
    func twohour_click() {
        schedule_img.image = UIImage(named: "schedule3")
        ordinary_button.backgroundColor = UIColor.clear
        advisory_button.backgroundColor = UIColor.clear
        assembly_button.backgroundColor = UIColor.clear
        twohour_button.backgroundColor = UIColor.blue
    }
    
    func go_to_app() {
        let url = URL(string: "GNNHS://")
        self.extensionContext?.open(url!, completionHandler: nil)
    }
    
}
