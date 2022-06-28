//
//  OnboardingCarouselCollectionViewCell.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/22.
//

import UIKit

class OnboardingCarouselCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    static let identifier = "OnboardingCarouselCollectionViewCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = max(self.frame.size.width, self.frame.size.height)/2
        
    }
}
