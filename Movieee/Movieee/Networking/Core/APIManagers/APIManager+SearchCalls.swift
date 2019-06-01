////
////  APIManager+SearchCalls.swift
////  LemiTravel
////
////  Created by Glenn Von C. Posadas on 29/05/2019.
////  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
////
//
//import Moya
//import Result
//
//extension APIManager {
//    /// Order calls
//    class SearchCalls: Base {
//        
//        typealias NewCitiesCallBack = ((_ cities: [City]?) -> Void)
//        
//        /*
//        static let stubbingProvider = MoyaProvider<OrderService>(stubClosure: MoyaProvider.immediatelyStub)
//        static let delayedStubbingProvider = MoyaProvider<OrderService>(stubClosure: MoyaProvider.delayedStub(3.0))
//        static let provider: MoyaProvider<OrderService> = delayedStubbingProvider//LLFEnv.llfEnvType == .unitTesting ? stubbingProvider : authServiceProvider*/
//        
//        /// Get all the cities
//        static func search(_ query: String, onSuccess: @escaping NewCitiesCallBack, onError: ErrorCallBack = nil) {
//            self.request(provider: searchServiceProvider, target: .search(query: query), onSuccess: { (data) in
//                let newCities = try? JSONDecoder().decode([City].self, from: data)
//                onSuccess(newCities)
//            }, onError: onError)
//        }
//    }
//}
//
//
