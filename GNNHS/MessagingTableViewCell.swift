//
//  MessagingTableViewCell.swift
//  GNNHS
//
//  Created by Noah Hanover on 1/30/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import UIKit

class MessagingTableViewCell: UITableViewCell {
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += 20
            frame.size.width = frame.size.width - 50
            if (frame.size.height != 44) {
                frame.size.height = frame.size.height+20
            }
            super.frame = frame
        }
    }
}
