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
    /// Get trending movies
    case getTrendingToday(page: Int)
    /// Search for specific movie
    case search(query: String, page: Int)
}

// MARK: - TargetType Protocol Implementationm

extension SearchService: TargetType {
    var baseURL: URL {
        return URL(string: baseURLString)!
    }
    
    var path: String {
        switch self {
        case .getTrendingToday: return "/trending/movie/day"
        case .search: return "/search/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTrendingToday: return .get
        case .search: return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getTrendingToday: return stubbedResponse("MovieResult")
        case .search: return stubbedResponse("MovieResult")
        }
    }
    
    var task: Task {
        switch self {
        case let .getTrendingToday(page):
            return .requestParameters(
                parameters: [
                    "api_key": MVKeys.tmDB.dev,
                    "page": page
                ], encoding: URLEncoding.default
            )
            
        case let .search(query, page):
            return .requestParameters(
                parameters: [
                    "api_key": MVKeys.tmDB.dev,
                    "language": "en-US",
                    "include_adult": true,
                    "page": page,
                    "query": query
                ], encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        return CoreService.getHeaders()
    }
}





