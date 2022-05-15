//
//  TodoViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/29.
//

import UIKit

class TodoViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

    }
    private func setupCollectionView() {
        
        // Delegate 연결
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 투두 셀 등록
        collectionView.register(
            UINib(nibName: "TodoCollectionViewCell",
                  bundle: nil),
            forCellWithReuseIdentifier: TodoCollectionViewCell.identifier)
        
        // 피니시드 리스트 셀 등록
        collectionView.register(
            UINib(nibName: "FinishedListCollectionViewCell",
                  bundle: nil),
            forCellWithReuseIdentifier: FinishedListCollectionViewCell.identifier)
        
        
    }
}

    // MARK: - Extension Collection View
extension TodoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // 섹션의 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    // 셀의 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        default:
            return 1
        }
    }

    
    // 셀 생성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoCollectionViewCell.identifier, for: indexPath) as? TodoCollectionViewCell else {
                fatalError("Cell Type Casting Failed..")
            }
            return cell
                
        default:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FinishedListCollectionViewCell.identifier, for: indexPath) as? FinishedListCollectionViewCell else {
                    fatalError("Cell Type Casting Failed..")
                }
                return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let collectionViewCell = cell as? FinishedListCollectionViewCell else {
            return
        }
        collectionViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }


// 셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let section = indexPath.section
        switch section {
        case 0:
            let inset = CGFloat(20)
            return CGSize(width: (collectionView.frame.width - (inset*2)), height: CGFloat(72))
        default:
            return CGSize(width: CGFloat(74), height: CGFloat(74))
            
        }
    }
    
    // 아이템 열간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(14)
        }
    }
    
    // 아이템 행간
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(8)
        default:
            return CGFloat(14)
        }
    }
}



