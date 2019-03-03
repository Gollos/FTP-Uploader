//
//  TableModel.swift
//  FTP-Uploader
//
//  Created by Golos on 3/8/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import UIKit

protocol ViewContainable {
    var view: UIView { get }
}

struct SectionModel {
    let title: String?
    let items: [CellViewAnyModel]
}

class TableModel: NSObject {
    private let tableView: UITableView
    
    struct Props {
        let sections: [SectionModel]
    }
    
    private var props = Props(sections: []) {
        didSet {
            (props.sections.flatMap { $0.items } as? [CellRegistering])?
                .forEach { $0.register(in: tableView) }
        }
    }
    
    init(style: UITableView.Style = .grouped, separatorStype: UITableViewCell.SeparatorStyle = .none) {
        tableView = UITableView(frame: .zero, style: style)
        
        super.init()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.estimatedSectionHeaderHeight = 100
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = separatorStype
    }
}

// MARK: TableModelProtocol
extension TableModel: ViewContainable {
    
    var view: UIView {
        return tableView
    }
}

// MARK: UITableViewDataSource
extension TableModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.sections[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return props.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return props.sections[indexPath.section].items[indexPath.row].cell(in: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return props.sections[indexPath.section].items[indexPath.row].height(in: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return props.sections[section].title
    }
}

// MARK: UITableViewDelegate
extension TableModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        props.sections[indexPath.section].items[indexPath.row].action()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TableModel {
    
    func render(props: Props) {
        self.props = props
        tableView.reloadData()
    }
}
