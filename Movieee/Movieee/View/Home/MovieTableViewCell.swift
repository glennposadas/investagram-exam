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
    
    @IBOutlet weak var cardView: UIView!
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
        
        // Turn off selection animation
        self.selectionStyle = .none
        // Remove separator
        self.removeSeparator()
        // Add shadow
        self.cardView.setupLayer(cornerRadius: 0)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 5,
            animations: {
                let value: CGFloat = self.isHighlighted ? 0.9 : 1.0
                self.cardView.transform = CGAffineTransform(scaleX: value, y: value)
        }, completion: nil)
    }
}
