//
//  TodoListCollectionViewCell.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/02.
//

import UIKit

class TodoListCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    var catId: Int = 0
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    
    
    // MARK: - Actions
    
    func configure(_ todo: CatTodo) {
        // 데이터를 불러와서 셀을 구성 (FC 프로젝트채팅리스트 2 영상 참조)
        catId = todo.catID
        iconImage.image = UIImage(named: todo.image)
        todoTitleLabel.text = todo.title
        timeLabel.text = todo.time
        
        
        if todo.isFinished == true {
            checkButton.isSelected = true
            
        } else {
            checkButton.isSelected = false
        }
    }
    
    
    
    // MARK: - Helpers
}
