//
//  NavigationState.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

enum AppDirection {
    case initial
    case login
}

struct NavigationState {
    let direction: AppDirection
}

func reduce(state: NavigationState, action: Action) -> NavigationState {
    if action is SetupLoginAction {
        return NavigationState(direction: .login)
        
    } else if action is AuthAction {
        return NavigationState(direction: .initial)
        
    } else {
        return state
    }
}
