//
//  APIManager+SearchCalls.swift
//  LemiTravel
//
//  Created by Glenn Von C. Posadas on 29/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Moya
import Result

extension APIManager {
    class SearchCalls: Base {

        typealias MovieResultCallBack = ((_ movieResult: MovieResult?) -> Void)

        /*
        static let stubbingProvider = MoyaProvider<OrderService>(stubClosure: MoyaProvider.immediatelyStub)
        static let delayedStubbingProvider = MoyaProvider<OrderService>(stubClosure: MoyaProvider.delayedStub(3.0))
        static let provider: MoyaProvider<OrderService> = delayedStubbingProvider//LLFEnv.llfEnvType == .unitTesting ? stubbingProvider : authServiceProvider*/

        /// Get all the trendng movies for the day
        static func getTrendingToday(page: Int, showHUD: Bool = true, onSuccess: @escaping MovieResultCallBack, onError: ErrorCallBack = nil) {
            self.request(provider: searchServiceProvider, target: .getTrendingToday(page: page), showHUD: showHUD, onSuccess: { (data) in
                let movieResult = try? JSONDecoder().decode(MovieResult.self, from: data)
                onSuccess(movieResult)
            }, onError: onError)
        }

        /// Paginated search.
        static func search(_ query: String, page: Int, showHUD: Bool = true, onSuccess: @escaping MovieResultCallBack, onError: ErrorCallBack = nil) {
            self.request(provider: searchServiceProvider, target: .search(query: query, page: page), showHUD: showHUD, onSuccess: { (data) in
                let movieResult = try? JSONDecoder().decode(MovieResult.self, from: data)
                onSuccess(movieResult)
            }, onError: onError)

        }
    }
}


