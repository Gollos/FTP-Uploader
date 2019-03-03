//
//  LoginAction.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

struct SetupLoginAction: Action {
    let title: String
    let buttonTitle: String
    let fields: [TextFieldModel]
}

struct AuthAction: Action {
    let token: String
    let lifetime: String
    let cookie: HTTPCookie?
}
