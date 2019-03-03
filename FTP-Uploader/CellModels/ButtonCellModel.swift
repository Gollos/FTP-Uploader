//
//  ButtonCellModel.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

struct ButtonCellModel {
    let title: String
    let actionHandler: () -> Void
}

// MARK: CellViewModel
extension ButtonCellModel: CellViewModel {
    
    func setup(cell: ButtonCell) {
        cell.selectionStyle = .none
        cell.loginButton.titleLabel?.text = title
        cell.loginHandler = actionHandler
    }
}
