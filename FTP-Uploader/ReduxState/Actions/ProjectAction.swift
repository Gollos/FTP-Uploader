//
//  ProjectAction.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

struct ProjectLoadingAction: Action {
    let loadingState: LoadingProgress<Result<[String: ProjectModel]>>
}

struct ProjectCellAction: Action {}
