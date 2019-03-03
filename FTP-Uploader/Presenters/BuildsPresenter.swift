//
//  BuildsPresenter.swift
//  FTP-Uploader
//
//  Created by Golos on 3/3/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

struct BuildsPresenter {
    typealias Props = TableViewController.Props
    typealias TableProps = TableModel.Props
    
    let render: CommandWith<Props>
    let tableRender: CommandWith<TableProps>
    let dispatch: CommandWith<Action>
}

extension BuildsPresenter {
    
    func present(state: State) {

    }
}
