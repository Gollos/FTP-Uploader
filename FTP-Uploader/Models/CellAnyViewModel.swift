//
//  CellAnyViewModel.swift
//  FTP-Uploader
//
//  Created by Golos on 3/8/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import UIKit

public protocol CellRegistering {
    func register(in table: UITableView)
}

public protocol CellViewAnyModel {
    var cellAnyType: UIView.Type { get }
    
    func setup(cell: UIView)
    func action()
    func cell(in tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func height(in tableView: UITableView, indexPath: IndexPath) -> CGFloat
}

extension CellViewAnyModel {
    
    var cellIdentifier: String {
        return String(describing: cellAnyType)
    }
    
    func action() {}
}

public protocol CellViewModel: CellViewAnyModel, CellRegistering {
    associatedtype CellType: UITableViewCell
    func setup(cell: CellType)
}

extension CellViewModel {
    
    var cellAnyType: UIView.Type {
        return CellType.self
    }
    
    func setup(cell: UIView) {
        setup(cell: cell as! CellType)
    }
    
    func cell(in tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withModel: self, for: indexPath)
    }
    
    func height(in tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: CellViewModel: CellRegistering
extension CellViewModel {
    
    func register(in table: UITableView) {
        table.register(CellType.self)
    }
}

extension UITableView {
    
    func dequeueReusableCell(withModel model: CellViewAnyModel, for indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath)
        model.setup(cell: cell)
        return cell
    }
}
