//
//  SearchService.swift
//  LemiTravel
//
//  Created by Glenn Von C. Posadas on 29/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation
import Moya

let searchServiceProvider = MoyaProvider<SearchService>(
    manager: moyaManager,
    plugins: [NetworkLoggerPlugin(verbose: CoreService.verbose)]
)

enum SearchService {
    /// Search for cities
    case search(query: String)
}

// MARK: - TargetType Protocol Implementationm

extension SearchService: TargetType {
    var baseURL: URL {
        return URL(string: baseURLString)!
    }
    
    var path: String {
        switch self {
        case .search: return "/cities"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search: return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .search: return stubbedResponse("Cities")
        }
    }

    var task: Task {
        switch self {
        case let .search(query):
            return .requestParameters(
                parameters: [
                    "q": query
                ], encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        return CoreService.getHeaders()
    }
}





