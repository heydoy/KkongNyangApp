//
//  TodoListCollectionViewCell.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/02.
//

import UIKit

class TodoListCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    
    // MARK: - Actions
    
    func configure() {
        // 데이터를 불러와서 셀을 구성 (FC 프로젝트채팅리스트 2 영상 참조) 
    }
    
    // MARK: - Helpers
}
