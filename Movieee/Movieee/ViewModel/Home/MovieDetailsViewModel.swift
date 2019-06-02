//
//  MovieDetailsViewModel.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 02/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

/// The delegate of the ```MovieDetailsViewModel```
protocol MovieDetailsDelegate: class {
    
}

class MovieDetailsViewModel: NSObject {
    
    // MARK: - Properties
    
    weak var delegate: MovieDetailsDelegate?
    
    // Inputs
    var movie: Movie!
    
    // MARK: Functions
    
    /// init
    init(movieDetailsController: MovieDetailsDelegate) {
        self.delegate = movieDetailsController
    }
}

