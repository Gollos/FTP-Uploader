//
//  HTTPCookieStorage+Category.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

protocol CookieStorageProtocol {
    var cookies: [HTTPCookie]? { get }
}

// MARK: CookieStorageProtocol
extension HTTPCookieStorage: CookieStorageProtocol {}
