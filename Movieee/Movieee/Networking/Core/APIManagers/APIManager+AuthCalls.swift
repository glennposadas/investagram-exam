//
//  APIManager+AuthCalls.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 02/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Moya
import Result

extension APIManager {
    class AuthCalls: Base {
        
        typealias TokenResultCallBack = ((_ tokenResult: TokenResult?) -> Void)
        
        /*
         static let stubbingProvider = MoyaProvider<OrderService>(stubClosure: MoyaProvider.immediatelyStub)
         static let delayedStubbingProvider = MoyaProvider<OrderService>(stubClosure: MoyaProvider.delayedStub(3.0))
         static let provider: MoyaProvider<OrderService> = delayedStubbingProvider//LLFEnv.llfEnvType == .unitTesting ? stubbingProvider : authServiceProvider*/
        
        /// Get request token
        static func newRequestToken(onSuccess: @escaping TokenResultCallBack, onError: ErrorCallBack = nil) {
            self.request(provider: authServiceProvider, target: .newToken, onSuccess: { (data) in
                let tokenResult = try? JSONDecoder().decode(TokenResult.self, from: data)
                onSuccess(tokenResult)
            }, onError: onError)
        }
        
        /// Validates login
        static func login(username: String, password: String, onSuccess: @escaping TokenResultCallBack, onError: ErrorCallBack = nil) {
            self.request(provider: authServiceProvider, target: .validate(username: username, password: password), onSuccess: { (data) in
                let tokenResult = try? JSONDecoder().decode(TokenResult.self, from: data)
                onSuccess(tokenResult)
            }, onError: onError)
            
        }
    }
}



