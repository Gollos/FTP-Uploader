//
//  UIView+ITTools.swift
//  FTP-Uploader
//
//  Created by Golos on 3/8/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import UIKit

extension UIView {
    
    @objc public func addConstraints(withVFL items: [String], options: NSLayoutConstraint.FormatOptions, metrics: [String: Any]?, views: [String: Any]) {
        
        addConstraints(
            items
                .map { NSLayoutConstraint.constraints(withVisualFormat: $0, options: options, metrics: metrics, views: views) }
                .flatMap { $0 }
        )
    }
    
    @objc public func addFullscreenConstraints(for subview: UIView) {
        
        // disable translatesAutoresizingMaskIntoConstraints
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        //add autolayout constraints
        let views = ["subview": subview]
        // Header view fills the width of its superview, // Header view fills the height of its superview
        addConstraints(withVFL: ["|[subview]|",
                                 "V:|[subview]|"],
                       options: [.alignAllCenterX,
                                 .alignAllCenterY],
                       metrics: nil,
                       views: views)
    }
}
