//
//  AlertViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit

class AlertViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 컬렉션 뷰 등록
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    // MARK: Actions
    

}

// MARK: - Extensions

extension AlertViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlertCollectionViewCell", for: indexPath) as? AlertCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
}


extension AlertViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let inset: CGFloat = 0
//        let width: CGFloat = collectionView.bounds.width - (inset * 2)
        return CGSize(width: collectionView.bounds.width, height: 95)
        // 추후에 완료버튼 없이 dynamic height 만들기
    }
}
