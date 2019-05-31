//
//  Movie+Helper.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 31/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation
import Kingfisher

extension Movie {
    /// The description used in the home cell.
    var homeCellDescription: String {
        get {
            return "You selected: \(self.name ?? "Unknown name")"
        }
    }
    
    /// Presentable name of the city.
    var namePresentable: String {
        get {
            return self.name ?? "Unknown name"
        }
    }
    
    /// Presentable country name of the city.
    var countryPresentable: String {
        get {
            return self.subtitle ?? "Uknown Country"
        }
    }
    
    /// Kingfisher's resource object for downloading avatar/banner of the city.
    /// Url is encoded.
    var bannerResource: Resource? {
        get {
            let imagePath = ""
            guard let url = self.banner?.URLEscaped else { return nil }
            return ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        }
    }
}
