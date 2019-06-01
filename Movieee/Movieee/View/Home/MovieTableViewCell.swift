//
//  MovieTableViewCell.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 31/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Kingfisher
import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var imageView_Poster: UIImageView!
    @IBOutlet weak var label_Title: UILabel!
    @IBOutlet weak var label_Date: UILabel!
    @IBOutlet weak var label_ApprovalRate: UILabel!
    @IBOutlet weak var label_Overview: UILabel!
    
    // MARK: - Functions
    
    func setupCell(_ movie: Movie) {
        self.label_Title.text = movie.titlePresentable
        self.label_Date.text = movie.releaseDatePresentable
        self.label_ApprovalRate.text = movie.approvalRatePresentable
        self.label_Overview.text = movie.overviewPresentable
        
        if let resource = movie.posterResource {
            self.imageView_Poster.kf.setImage(with: resource, options: [.transition(.fade(0.2)), .cacheOriginalImage])
            return
        }
        
        self.imageView_Poster.image = nil
    }
    
    // MARK: Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
