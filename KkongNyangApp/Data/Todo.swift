//
//  CatTodo.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/03.
//

import Foundation
import UIKit
import FirebaseDatabase

class Todo: Comparable {
    static func == (lhs: Todo, rhs: Todo) -> Bool {
        return lhs.title == rhs.title
    }
    
    static func < (lhs: Todo, rhs: Todo) -> Bool {
        return lhs.time < rhs.time
    }
    
    var key = ""
    var catId = ""
    var title = ""
    var time = ""
    var image = ""
    var memo = ""
    var isFinished: Bool = false
    var finishTime = ""
    
    
    init(withSnapshot: DataSnapshot) {
        self.key = withSnapshot.key
        self.catId = withSnapshot.childSnapshot(forPath: "catId").value as? String ?? ""
        self.title = withSnapshot.childSnapshot(forPath: "title").value as? String ?? ""
        self.time = withSnapshot.childSnapshot(forPath: "time").value as? String ?? ""
        self.image = withSnapshot.childSnapshot(forPath: "image").value as? String ?? ""
        self.memo = withSnapshot.childSnapshot(forPath: "memo").value as? String ?? ""
        self.isFinished = withSnapshot.childSnapshot(forPath: "isFinished").value as? Bool ?? false
        self.finishTime = withSnapshot.childSnapshot(forPath: "finishTime").value as? String ?? ""
        
    }
}


extension Todo {
    static let TitleList: [String] = [
        
        "식사주기", "간식주기", "화장실청소", "놀아주기", "병원가기",
        "약 먹이기", "고양이용품 구매", "발톱깎이기 & 귀청소", "기타"
    ]
    static let IconList: [String] = [
        "catfood", "catsnack", "cattoilet", "catgame", "catdoctor",
        "catpill", "catshoppingbasket", "catjelly", "catwrite"
    ]
}

