//
//  PalateCollectionViewCell.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit

class PalateCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var preferenceFace: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var versionHistory: UILabel!
    
    // MARK: - Actions
    
    func configure() {
        
    }
}
