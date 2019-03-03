//
//  UITableViewCell+Category.swift
//  FTP-Uploader
//
//  Created by Golos on 3/8/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    
    static func loadFromNib() -> Self? {
        return UINib.init(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? Self
    }
}

protocol ReusableView: class {}
extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: NibLoadableView {}
extension UITableViewCell: ReusableView {}
extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func cell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        guard let cell = cellForRow(at: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
