//
//  FlowCoordinator.swift
//  FTP-Uploader
//
//  Created by Golos on 3/3/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import UIKit

// swiftlint:disable private_over_fileprivate
fileprivate let appBaseURL = "http://m.itcraftlab.com/api.php?action="

fileprivate let store = Store(state: State(apiState: ApiState(baseURL: appBaseURL, accessToken: ""),
                                           projectState: ProjectState(loadingState: .none),
                                           navigationState: NavigationState(direction: .initial),
                                           loginState: LoginState(title: "", buttonTitle: "", fields: []),
                                           storageState: StorageState(token: "", lifetime: "", cookie: nil)),
                              reduce: reduce)
// swiftlint:enable private_over_fileprivate

final class FlowCoordinator {
    
    struct Props {
        let direction: AppDirection
    }
    
    private var props = Props(direction: .initial) {
        didSet {
            guard oldValue.direction != props.direction else { return }
            
            switch props.direction {
            case .initial:
                navigateToInitial()
            case .login:
                navigateToLogin(apiManager: apiManager)
            }
        }
    }
    
    private let splitViewController = UISplitViewController()
    private let apiManager = APIManager()
    private let storage: DefaultStorageProtocol = DefaultStorage(defaultStorage: UserDefaults.standard)
    private let cookiesStorage: CookieStorageProtocol = HTTPCookieStorage.shared
    
    init(window: UIWindow?) {
        store.observe(with: newState)
        store.observe(with: apiManager.newState)
        
        window?.rootViewController = splitViewController
        
        let projectTableModel = TableModel(separatorStype: .singleLine)
        let projectVC = TableViewController(tableModel: projectTableModel)
        
        let buildsTableModel = TableModel()
        let buildsVC = TableViewController(tableModel: buildsTableModel)
        
        splitViewController.delegate = projectVC
        splitViewController.viewControllers.append(contentsOf: [UINavigationController(rootViewController: projectVC),
                                                                UINavigationController(rootViewController: buildsVC)])
        window?.makeKeyAndVisible()
        
        setupProject(vc: projectVC, tableModel: projectTableModel, apiManager: apiManager)
        setupBuilds(vc: buildsVC, tableModel: buildsTableModel)
        
        store.dispatch(action: SetupLoginAction(title: NSLocalizedString("FTP Uploader", comment: ""),
                                                buttonTitle: NSLocalizedString("Login", comment: ""),
                                                fields: [TextFieldModel(placeholder: "Login", errorIsHidden: true, isSecureField: false),
                                                         TextFieldModel(placeholder: "Password", errorIsHidden: true, isSecureField: true)
            ])
        )
    }
    
    private func setupProject(vc: TableViewController, tableModel: TableModel, apiManager: APIManagerProtocol) {
        let presenter = ProjectPresenter(
            render: CommandWith(action: vc.render).dispatched(on: .main),
            tableRender: CommandWith(action: tableModel.render).dispatched(on: .main),
            dispatch: CommandWith(action: store.dispatch),
            fetch: { apiManager.perform(request: .project) }
        )
        store.observe(with: presenter.present)
    }
    
    private func setupBuilds(vc: TableViewController, tableModel: TableModel) {
        let presenter = BuildsPresenter(
            render: CommandWith(action: vc.render).dispatched(on: .main),
            tableRender: CommandWith(action: tableModel.render).dispatched(on: .main),
            dispatch: CommandWith(action: store.dispatch)
        )
        store.observe(with: presenter.present)
    }
    
    private func navigateToLogin(apiManager: APIManagerProtocol) {
        let tableModel = TableModel()
        let vc = TableViewController(tableModel: tableModel)
        let presenter = LoginPresenter(
            render: CommandWith(action: vc.render).dispatched(on: .main),
            tableRender: CommandWith(action: tableModel.render).dispatched(on: .main),
            dispatch: CommandWith(action: store.dispatch),
            fetch: { apiManager.perform(request: .auth(login: $0, password: $1)) },
            cookies: { [weak self] in self?.cookiesStorage.cookies?.first }
        )
        store.observe(with: presenter.present)
        
        vc.modalPresentationStyle = .formSheet
        topVC?.present(vc, animated: true, completion: nil)
    }
    
    private func navigateToInitial() {
        topVC?.dismiss(animated: true) {
            store.dispatch(action: ProjectLoadingAction(loadingState: .none))
        }
    }
    
    private var topVC: UIViewController? {
        guard let currentVC = splitViewController.viewControllers.last else { return nil }
        
        var vc = currentVC
        
        while let presentedVC = vc.presentedViewController {
            vc = presentedVC
        }
        return vc
    }
}

extension FlowCoordinator {
    
    func newState(state: State) {
        props = Props(direction: state.navigationState.direction)
    }
}
