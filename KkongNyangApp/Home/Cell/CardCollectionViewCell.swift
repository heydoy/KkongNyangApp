//
//  CardCollectionViewCell.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardImageBackground: UIView!
    
    @IBOutlet weak var cardTitle: UILabel!
    
    @IBOutlet weak var cardDescription: UILabel!
    @IBOutlet weak var cardDate: UILabel!
    @IBOutlet weak var textBackground: UIView!
    
    // MARK: - Actions
    
    func configure(_ homecard: HomeCard){
        cardImage.image = UIImage(named: homecard.image)
        cardImageBackground.backgroundColor = UIColor(named: homecard.imageBackground)
        cardTitle.text = homecard.title
        cardDescription.text = homecard.description
        cardDate.text = homecard.date
        
        setAttribute()
    }
    
    
    // MARK: - Helpers
    
    func setAttribute() {
        cardImageBackground.layer.cornerRadius = 16
        
        
        // 텍스트는 아래만 라운드를 줄 것
        textBackground.roundCorners(cornerRadius: 16, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
    }
}