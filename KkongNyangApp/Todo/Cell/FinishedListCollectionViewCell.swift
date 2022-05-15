//
//  FinishedListCollectionViewCell.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/08.
//

import UIKit

class FinishedListCollectionViewCell: UICollectionViewCell {
    static let identifier = "FinishedListCollectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate : UICollectionViewDelegate & UICollectionViewDataSource, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        
        collectionView.tag = row
        
        let finishNib = UINib(nibName: "FinishedCollectionViewCell", bundle: nil)
        collectionView.register(finishNib, forCellWithReuseIdentifier: "FinishedCollectionViewCell")
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.reloadData()
    }
    
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
