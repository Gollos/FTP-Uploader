//
//  AuthModel.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

struct AuthModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case sessionLifetime = "session_lifetime"
    }
    
    let accessToken: String
    let sessionLifetime: String
}
