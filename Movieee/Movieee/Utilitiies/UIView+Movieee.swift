//
//  UIView+Movieee.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 01/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

extension UIView {
    /**
     Setups the layer of a view.
     - paramters:
     - shadowOffset: Controls the spread.
     - shadowRadius: Controls the blur
     */
    func setupLayer(
        cornerRadius: CGFloat = 22,
        borderWidth: CGFloat = 0,
        borderColor: UIColor = .clear,
        shadowOffSet: CGSize = CGSize(width: 0, height: 1),
        shadowColor: UIColor = UIColor(red:0, green:0, blue:0, alpha:0.15),
        shadowOpacity: Float = 1,
        shadowRadius: CGFloat = 2,
        shouldClipToBounds: Bool = false
        ) {
        
        self.layer.cornerRadius     = cornerRadius
        self.layer.borderWidth      = borderWidth
        self.layer.borderColor      = borderColor.cgColor
        self.layer.shadowOffset     = shadowOffSet
        self.layer.shadowColor      = shadowColor.cgColor
        self.layer.shadowOpacity    = shadowOpacity
        self.layer.shadowRadius     = shadowRadius
        self.clipsToBounds = shouldClipToBounds
    }

}
