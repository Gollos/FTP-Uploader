//
//  UIView+Nib.swift
//  FTP-Uploader
//
//  Created by Golos on 3/8/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import UIKit

extension UIView {
    
    class var nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }
}
