//
//  ProjectPresenter.swift
//  FTP-Uploader
//
//  Created by Golos on 3/3/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

struct ProjectPresenter {
    typealias Props = TableViewController.Props
    typealias TableProps = TableModel.Props
    
    let render: CommandWith<Props>
    let tableRender: CommandWith<TableProps>
    let dispatch: CommandWith<Action>
    let fetch: () -> Future<Result<[String: ProjectModel]>>
    
    private func loadModels() {
        fetch()
            .onSuccess {
                let cellModels = $0.values.map { ProjectCellModel(item: $0, dispatch: self.dispatch) }
                let section = SectionModel(title: nil, items: cellModels)
                self.tableRender.perform(with: TableProps(sections: [section]))
                self.dispatch.perform(with: ProjectLoadingAction(loadingState: .finish(.success($0))))
            }
            .onError {
                self.dispatch.perform(with: ProjectLoadingAction(loadingState: .finish(.failure($0))))
                print("Error: \($0)")
        }
        dispatch.perform(with: ProjectLoadingAction(loadingState: .loading))
    }
}

extension ProjectPresenter {
    
    func present(state: State) {
        switch state.projectState.loadingState {
        case .none:
            loadModels()
        case .loading:
            render.perform(with: Props(isLoading: true))
        case .finish:
            render.perform(with: Props(isLoading: false))
        }
    }
}
