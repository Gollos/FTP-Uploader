//
//  APIRequest.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

struct APIRequest<T: Decodable> {
    enum TypeName: String {
        case POST, GET, PUT, DELETE
    }
    
    let type: TypeName
    let postParameters: [String: Any]?
    let getParameters: [String: Any]?
    let urlAdditionalPath: String
    let isTokenRequired: Bool
}

extension APIRequest {
    
    enum RequestType: String {
        case projects, login
    }
    
    static var project: APIRequest<[String: ProjectModel]> {
        return APIRequest<[String: ProjectModel]>(type: .GET,
                                                  postParameters: nil,
                                                  getParameters: ["show_all": "0"],
                                                  urlAdditionalPath: RequestType.projects.rawValue,
                                                  isTokenRequired: true)
    }
    
    static func auth(login: String, password: String, deviceToken: String? = nil) -> APIRequest<AuthModel> {
        var postParameters: [String: Any] = ["login": login, "password": password, "keep_login": true]
        
        if let deviceToken = deviceToken {
            postParameters["device_token"] = deviceToken
        }
        return APIRequest<AuthModel>(type: .POST,
                                     postParameters: postParameters,
                                     getParameters: nil,
                                     urlAdditionalPath: RequestType.login.rawValue,
                                     isTokenRequired: false)
    }
}
