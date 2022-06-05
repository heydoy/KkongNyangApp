//
//  PalateCollectionViewCell.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit

class PalateCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var catID: Int = 0
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var preferenceFace: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var memo: UILabel!
    @IBOutlet weak var versionHistory: UILabel!
    
    // MARK: - Actions
    
    func configure(_ palate: CatPalate) {
        catID = palate.catID
        productImage.image = UIImage(named: palate.itemImage)
        preferenceFace.text = makeFace(palate.preferenceLevel)
        productName.text = palate.itemName
        memo.text = palate.memo
        versionHistory.text = palate.history
        
        
    }
    
    // MARK: - Helpers
    func makeFace(_ level: Float) -> String {
        var face: String
        if level < 0.2 {
            // 극혐함
            face = "🤮"
            
        } else if level > 0.2 && level < 0.4 {
            face = "😩"
        } else if level > 0.4 && level < 0.6 {
            face = "😶"
        } else if level > 0.6 && level < 0.8 {
            face = "😘"
        } else {
            // 제일 좋아함
            face = "😍"
        }
        
        return face
        
    }
}
