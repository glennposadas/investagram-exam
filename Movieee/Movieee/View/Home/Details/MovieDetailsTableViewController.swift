//
//  MovieDetailsViewController.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 02/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var viewModel: MovieDetailsViewModel = {
       let viewModel = MovieDetailsViewModel(movieDetailsController: self)
        return viewModel
    }()
    
    @IBOutlet weak var imageView_Backdrop: UIImageView!
    @IBOutlet weak var imageView_Poster: UIImageView!
    @IBOutlet weak var label_Title: UILabel!
    @IBOutlet weak var label_Date: UILabel!
    @IBOutlet weak var label_ApprovalRate: UILabel!
    @IBOutlet weak var label_Overview: UILabel!
    
    // MARK: - Functions
    
    private func setupBindings() {
        let movie = self.viewModel.movie!
        self.label_Title.text = movie.titlePresentable
        self.label_Date.text = movie.releaseDatePresentable
        self.label_ApprovalRate.text = movie.approvalRatePresentable
        self.label_Overview.text = movie.overviewPresentable
        
        if let resource = movie.posterResource {
            self.imageView_Poster.kf.setImage(with: resource, options: [.transition(.fade(0.2)), .cacheOriginalImage])
            return
        }
        
        if let resource = movie.backdropResource {
            self.imageView_Backdrop.kf.setImage(with: resource, options: [.transition(.fade(0.2)), .cacheOriginalImage])
            return
        }
    }
    
    // MARK: Overrides
    
    private func setupUI() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBindings()
        self.setupUI()
    }
    
}

// MARK: - MovieDetailsDelegate

extension MovieDetailsViewController: MovieDetailsDelegate {
    
}
