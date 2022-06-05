//
//  FinishedTodoCollectionViewCell.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit

class FinishedTodoCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var finishedImage: UIImageView!
    @IBOutlet weak var finishedTitle: UILabel!
    @IBOutlet weak var finishedView: UIView!
    
    // MARK: Actions
    
    func configure(_ finishedTodo: FinishedTodo){
        finishedImage.image = UIImage(named: finishedTodo.image)
        finishedTitle.text = finishedTodo.title
        finishedView.backgroundColor = UIColor(named: finishedTodo.backgroundColor)
    }
    
}
