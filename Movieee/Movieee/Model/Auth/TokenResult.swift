//
//  TokenResult.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 01/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation

struct TokenResult: Codable {
    
    let expiresAt : String?
    let requestToken : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case expiresAt = "expires_at"
        case requestToken = "request_token"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        expiresAt = try values.decodeIfPresent(String.self, forKey: .expiresAt)
        requestToken = try values.decodeIfPresent(String.self, forKey: .requestToken)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}

