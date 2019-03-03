//
//  APIManager.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation
import Alamofire

protocol APIManagerProtocol {
    func perform<T: Decodable>(request: APIRequest<T>) -> Future<Result<T>>
}

final class APIManager {
    
    struct Props {
        let baseURL: String
        let accessToken: String
    }
    
    private var props = Props(baseURL: "", accessToken: "")
    
    private func networkRequest<T>(request: APIRequest<T>) throws -> DataRequest {
        let baseURLString = props.baseURL + request.urlAdditionalPath
        guard let baseURL = URL(string: baseURLString) else { throw APIError.wrongURLSettings }
        
        let urlRequest = URLRequest(url: baseURL)
        let encodedURL = try? URLEncoding().encode(urlRequest, with: request.getParameters).url ?? baseURL
        
        guard let finalURL = encodedURL,
            let method = HTTPMethod(rawValue: request.type.rawValue) else { throw APIError.wrongURLSettings }
        
        var postParams = request.postParameters ?? [:]
        
        if request.isTokenRequired {
            postParams["access_token"] = props.accessToken
        }
        let alamofireRequest = Alamofire.request(finalURL, method: method, parameters: postParams)
        return alamofireRequest
    }
}

// MARK: APIManagerProtocol
extension APIManager: APIManagerProtocol {
    
    func perform<T: Decodable>(request: APIRequest<T>) -> Future<Result<T>> {
        return Future<Result<T>> { completion in
            do {
                let apiRequest = try networkRequest(request: request)
                
                apiRequest.validate().responseData { response in
                    if let data = response.data, let serverResponse = try? JSONDecoder().decode(T.self, from: data) {
                        completion(.success(serverResponse))
                        
                    } else if let error = response.error, [-1001, -1003, -1005, -1009].contains((error as NSError).code) {
                        completion(.failure(.badInternetConnection))
                        
                    } else if let error = response.error {
                        completion(.failure(.custom(error)))
                        
                    } else {
                        completion(.failure(.unknown))
                    }
                }
            } catch let error {
                completion(.failure(.custom(error)))
            }
        }
    }
}

extension APIManager {
    
    func newState(state: State) {
        props = Props(baseURL: state.apiState.baseURL,
                      accessToken: state.apiState.accessToken)
    }
}
