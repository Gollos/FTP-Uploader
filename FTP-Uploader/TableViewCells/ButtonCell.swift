//
//  ButtonCell.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {
    @IBOutlet weak var loginButton: UIButton!
    
    var loginHandler: (() -> Void)?
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        loginHandler?()
    }
}
