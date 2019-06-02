//
//  AuthService.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 02/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation
import Moya

let authServiceProvider = MoyaProvider<AuthService>(
    manager: moyaManager,
    plugins: [NetworkLoggerPlugin(verbose: CoreService.verbose)]
)

enum AuthService {
    case newToken
    case validate(username: String, password: String)
}

// MARK: - TargetType Protocol Implementationm

extension AuthService: TargetType {
    var baseURL: URL {
        return URL(string: baseURLString)!
    }
    
    var path: String {
        switch self {
        case .newToken: return "/authentication/token/new"
        case .validate: return "/authentication/token/validate_with_login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .newToken: return .get
        case .validate: return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .newToken:
            return .requestParameters(
                parameters: [
                    "api_key": MVKeys.tmDB.dev
                ], encoding: URLEncoding.default
            )
            
        case let .validate(username, password):
            return .requestParameters(
                parameters: [
                    "api_key": MVKeys.tmDB.dev,
                    "username": username,
                    "password": password,
                    "request_token": MVDefaults.getObjectWithKey(.requestToken, type: String.self) ?? ""
                ], encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        return CoreService.getHeaders()
    }
}





