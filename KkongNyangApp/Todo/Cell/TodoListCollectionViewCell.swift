//
//  TodoListCollectionViewCell.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/02.
//

import UIKit

class TodoListCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    var catId: String = ""
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var finishedStamp: UIImageView!
    
    
    // MARK: - Actions
    
    func configure(_ todo: Todo) {
        // 데이터를 불러와서 셀을 구성 (FC 프로젝트채팅리스트 2 영상 참조)
        catId = todo.catId
        iconImage.image = UIImage(named: todo.image)
        todoTitleLabel.text = todo.title
        timeLabel.text = todo.time
        
        
        if todo.isFinished == true {
            finishedStamp.alpha = 1
            
            
        } else {
            finishedStamp.alpha = 0
        }
    }
    
    
    
    // MARK: - Helpers
}
