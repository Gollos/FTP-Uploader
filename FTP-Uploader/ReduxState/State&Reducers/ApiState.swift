//
//  ApiState.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

enum LoadingProgress<T> {
    case none
    case loading
    case finish(T)
}

struct ApiState {
    let baseURL: String
    let accessToken: String
}

func reduce(state: ApiState, action: Action) -> ApiState {
    switch action {
    case let action as AuthAction:
        return ApiState(baseURL: state.baseURL, accessToken: action.token)
    default:
        return state
    }
}
