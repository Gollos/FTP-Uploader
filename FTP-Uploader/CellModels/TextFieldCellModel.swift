//
//  TextFieldCellModel.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

final class TextFieldCellModel {
    let item: TextFieldModel
    private(set) var textFieldText: (() -> String?)?
    
    init(item: TextFieldModel) {
        self.item = item
    }
}

// MARK: CellViewModel
extension TextFieldCellModel: CellViewModel {
    
    func setup(cell: TextFieldCell) {
        cell.selectionStyle = .none
        cell.textField.placeholder = item.placeholder
        cell.textField.isSecureTextEntry = item.isSecureField
        cell.errorLabel.text = NSLocalizedString(String(format: "%@ is required", item.placeholder), comment: "")
        cell.errorLabel.isHidden = item.errorIsHidden

        textFieldText = { cell.textField.text }
    }
}
