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
    
    // MARK: - Actions
    
    func configure(_ homecard: HomeCard){
        cardImage.image = UIImage(named: homecard.image)
        cardImageBackground.backgroundColor = UIColor(named: homecard.imageBackground)
        cardTitle.text = homecard.title
        cardDescription.text = homecard.description
        cardDate.text = homecard.date
    }
    
    
    // MARK: - Helpers
}
