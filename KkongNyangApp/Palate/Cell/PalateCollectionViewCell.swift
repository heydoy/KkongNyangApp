//
//  PalateCollectionViewCell.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class PalateCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    // Firebase DB 주소
    let db: DatabaseReference! = Database.database(url: "https://kkongnyangapp-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    
    var catID = "0"
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var preferenceFace: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var memo: UILabel!
    @IBOutlet weak var history: UILabel!
    // MARK: - Actions
    
    func configure(_ palate: Palate) {
        catID = palate.catID
        productImage.image = UIImage(named: palate.image)
        preferenceFace.text = makeFace(palate.like)
        productName.text = palate.name
        memo.text = palate.memo
        history.text = palate.history

    }
    
    // MARK: - Helpers
    func makeFace(_ level: Double) -> String {
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
    
    func setHistory() -> String {
        // 사용자 이름 가져오기
        let user = Auth.auth().currentUser
        var uid = ""
        if let user = user {
            uid = user.uid
        }
        
        var username = ""
        
        self.db.child("users/\(uid)/name").getData { error, snapshot in
            username = (snapshot?.value as? String)!
        }
        
        // 현재 날짜 가져오기
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일 h시"
        let convertString = dateFormatter.string(from: nowDate)
        
        let history = "\(username)이 \(convertString) 기록"
        
        return history
    }
    
}
