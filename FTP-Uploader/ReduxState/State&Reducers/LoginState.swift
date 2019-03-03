//
//  LoginState.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

struct TextFieldModel {
    let placeholder: String
    let errorIsHidden: Bool
    let isSecureField: Bool
}

struct LoginState {
    let title: String
    let buttonTitle: String
    let fields: [TextFieldModel]
}

func reduce(state: LoginState, action: Action) -> LoginState {
    switch action {
    case let action as SetupLoginAction:
        return LoginState(title: action.title, buttonTitle: action.buttonTitle, fields: action.fields)
    default:
        return state
    }
}
