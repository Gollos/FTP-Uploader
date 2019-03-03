//
//  ProjectState.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

struct ProjectState {
    let loadingState: LoadingProgress<Result<[String: ProjectModel]>>
}

func reduce(state: ProjectState, action: Action) -> ProjectState {
    switch action {
    case let action as ProjectLoadingAction:
        return ProjectState(loadingState: action.loadingState)
    default:
        return state
    }
}
