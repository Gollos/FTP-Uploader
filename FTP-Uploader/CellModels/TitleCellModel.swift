//
//  TitleCellModel.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

struct TitleCellModel {
    let title: String
}

// MARK: CellViewModel
extension TitleCellModel: CellViewModel {
    
    func setup(cell: TitleCell) {
        cell.selectionStyle = .none
        cell.title.text = title
    }
}
