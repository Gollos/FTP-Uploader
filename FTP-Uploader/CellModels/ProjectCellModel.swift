//
//  ProjectCellModel.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import UIKit

struct ProjectCellModel {
    let item: ProjectModel
    let dispatch: CommandWith<Action>
}

// MARK: CellViewModel
extension ProjectCellModel: CellViewModel {
    
    func setup(cell: UITableViewCell) {
        cell.textLabel?.text = item.name
    }
    
    func action() {
        dispatch.perform(with: ProjectCellAction())
    }
    
    func register(in table: UITableView) {
        table.register(cellClass: UITableViewCell.self)
    }
}
