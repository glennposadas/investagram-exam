//
//  MovieTableViewCell.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 31/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var view_LabelContainer: BleedingView!
    @IBOutlet weak var imageView_Banner: UIImageView!
    @IBOutlet weak var label_Title: UILabel!
    @IBOutlet weak var label_Date: UILabel!
    @IBOutlet weak var label_ApprovalRate: UILabel!
    
    // MARK: - Functions
    
    func setupCell(_ movie: Movie) {
        
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
