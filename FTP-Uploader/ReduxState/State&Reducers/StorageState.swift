//
//  StorageState.swift
//  FTP-Uploader
//
//  Created by Golos on 3/10/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

struct StorageState {
    let token: String
    let lifetime: String
    let cookie: HTTPCookie?
}

func reduce(state: StorageState, action: Action) -> StorageState {
    switch action {
    case let action as AuthAction:
        return StorageState(token: action.token, lifetime: action.lifetime, cookie: action.cookie)
    default:
        return state
    }
}
