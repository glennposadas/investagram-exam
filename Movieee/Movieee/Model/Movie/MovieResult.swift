//
//  MovieResult.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 31/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation

struct MovieResult: Codable {
    
    let movies : [Movie]?
    var page : Int?
    let totalPages : Int?
    let totalResults : Int?
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page = "page"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movies = try values.decodeIfPresent([Movie].self, forKey: .movies)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(movies, forKey: .movies)
        try container.encode(page, forKey: .page)
        try container.encode(totalPages, forKey: .totalPages)
        try container.encode(totalResults, forKey: .totalResults)
    }
}
