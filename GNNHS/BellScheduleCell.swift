//
//  BellScheduleCell.swift
//  GNNHS
//
//  Created by Noah Hanover on 11/3/15.
//  Copyright © 2015 Noah Hanover. All rights reserved.
//

import UIKit



class BellScheduleCell: AEAccordionTableViewCell {
    
    let detailView = UIImageView(frame: CGRect(x: 0, y: 50, width: MainTabBar().WIDTH, height: 350))
    let headerView = UILabel(frame: CGRect(x: 15, y: 0, width: MainTabBar().WIDTH, height: 44))
    let iPhoneHeight = UIScreen.main.bounds.height
    
    
    override func setExpanded(_ expanded: Bool, animated: Bool) {
        super.setExpanded(expanded, animated: animated)
        
        let orientation = UIApplication.shared.statusBarOrientation
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad && (orientation == UIInterfaceOrientation.portrait || orientation == UIInterfaceOrientation.portraitUpsideDown)) {
            headerView.frame = CGRect(x: 47.5, y: 0, width: self.frame.width, height: 44)
            detailView.frame = CGRect(x: 0, y: 50, width: self.frame.width, height: 700)
        } else if (orientation == UIInterfaceOrientation.landscapeLeft || orientation == UIInterfaceOrientation.landscapeRight) {
            headerView.frame = CGRect(x: 175, y: 0, width: self.frame.width, height: 44)
            detailView.frame = CGRect(x: 115, y: 50, width: 768, height: 700)
        }
        else {
        
            if (iPhoneHeight == 667.0) {
                // iPhone 6
                detailView.frame = CGRect(x: 0, y: 50, width: self.frame.width, height: 400)
                
            } else if (iPhoneHeight == 736.0) {
                // iPhone 6 Plus
                detailView.frame = CGRect(x: 0, y: 50, width: self.frame.width, height: 450)
            }
        }
        self.addSubview(detailView)
        self.addSubview(headerView)
        
        if !animated {
            toggleCell()
        } else {
            UIView.transition(with: detailView, duration: 0.3, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                self.toggleCell()
                }, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
    func toggleCell() {
        detailView.isHidden = !expanded
        //headerView.transform = expanded ? CGAffineTransformMakeRotation(CGFloat(M_PI)) : CGAffineTransformIdentity
    }
}
