//
//  Result.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

protocol ResultType {
    associatedtype ValueType
    
    var asResult: Result<ValueType> { get }
}

enum APIError: Error {
    case wrongURLSettings
    case badInternetConnection
    case custom(Error)
    case unknown
}

enum Result<T> {
    case success(T)
    case failure(APIError)
}

// MARK: ResultType
extension Result: ResultType {
    public typealias ValueType = T
    
    public var asResult: Result<ValueType> { return self }
}
