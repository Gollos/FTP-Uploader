//
//  LoginPresenter.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

struct LoginPresenter {
    typealias Props = TableViewController.Props
    typealias TableProps = TableModel.Props
    
    let render: CommandWith<Props>
    let tableRender: CommandWith<TableProps>
    let dispatch: CommandWith<Action>
    let fetch: (String, String) -> Future<Result<AuthModel>>
    let cookies: () -> HTTPCookie?
    
    private func login(with login: String, password: String) {
        render.perform(with: Props(isLoading: true))
        
        self.fetch(login, password)
            .onSuccess {
                guard let cookie = self.cookies() else { return }
                self.dispatch.perform(with: AuthAction(token: $0.accessToken,
                                                       lifetime: $0.sessionLifetime,
                                                       cookie: cookie))
                self.render.perform(with: Props(isLoading: false))
            }
            .onError {
                print("Error: \($0)")
                self.render.perform(with: Props(isLoading: false))
        }
    }
    
    private func setupTable(state: LoginState) {
        var cellModels: [CellViewAnyModel] = [TitleCellModel(title: state.title)]
        let textFields = state.fields.map { TextFieldCellModel(item: $0) }
        cellModels.append(contentsOf: textFields)
        
        let buttonModel = ButtonCellModel(title: state.buttonTitle) {
            let login = textFields.first?.textFieldText?() ?? ""
            let password = textFields.last?.textFieldText?() ?? ""
            
            self.login(with: login, password: password)
        }
        cellModels.append(buttonModel)
        
        let section = SectionModel(title: nil, items: cellModels)
        
        tableRender.perform(with: TableProps(sections: [section]))
    }
}

extension LoginPresenter {
    
    func present(state: State) {
        setupTable(state: state.loginState)
    }
}
