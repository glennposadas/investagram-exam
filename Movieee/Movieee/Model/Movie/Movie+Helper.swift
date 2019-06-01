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
    
    /// Presentable movie title
    var titlePresentable: String {
        get {
            return self.title ?? (self.originalName ?? "Unknown Title")
        }
    }
    
    /// Presentable name of the city.
    var releaseDatePresentable: String {
        get {
            let dateString = self.releaseDate ?? (self.firstAirDate ?? "")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if let origFormattedDate = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "MMMM d, yyyy"
                let formattedStringDate = dateFormatter.string(from: origFormattedDate)
                return formattedStringDate
            }
            
            return self.releaseDate ?? "Unknown Date"
        }
    }
    
    /// The presentable approval rate
    var approvalRatePresentable: String {
        get {
            let approvalRate: Int = Int((self.voteAverage ?? 0) * 10.0)
            return "\(approvalRate)%"
        }
    }

    /// The presentabl overview
    var overviewPresentable: String {
        get {
            return self.overview ?? ""
        }
    }

    /// Kingfisher's resource object for downloading the poster of the movie. Vertical Rectangle image
    /// Url is encoded.
    var posterResource: Resource? {
        get {
            let imagePath = "\(baseImagePath)/w300/\(self.posterPath ?? "")"
            guard let url = imagePath.URLEscaped else { return nil }
            return ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        }
    }
    
    /// Kingfisher's resource object for downloading the backdrop of the movie. The horizontal rect banner image
    /// Url is encoded.
    var backdropResource: Resource? {
        get {
            let imagePath = "\(baseImagePath)/w300/\(self.backdropPath ?? "")"
            guard let url = imagePath.URLEscaped else { return nil }
            return ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        }
    }
    
}
