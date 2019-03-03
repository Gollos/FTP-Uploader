//
//  State.swift
//  FTP-UploaderReduxState
//
//  Created by Golos on 3/3/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

struct State {
    let apiState: ApiState
    let projectState: ProjectState
    let navigationState: NavigationState
    let loginState: LoginState
    let storageState: StorageState
}

func reduce(state: State, action: Action) -> State {
    return State(apiState: reduce(state: state.apiState, action: action),
                 projectState: reduce(state: state.projectState, action: action),
                 navigationState: reduce(state: state.navigationState, action: action),
                 loginState: reduce(state: state.loginState, action: action),
                 storageState: reduce(state: state.storageState, action: action))
}
