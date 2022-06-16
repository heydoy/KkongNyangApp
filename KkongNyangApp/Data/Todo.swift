//
//  CatTodo.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/03.
//

import Foundation
import UIKit
import FirebaseDatabase

class Todo {
    var catId = ""
    var title = ""
    var time = ""
    var image = ""
    var memo = ""
    var isFinished: Bool = false
    
    
    init(withSnapshot: DataSnapshot) {
        self.catId = withSnapshot.childSnapshot(forPath: "catId").value as? String ?? ""
        self.title = withSnapshot.childSnapshot(forPath: "title").value as? String ?? ""
        self.time = withSnapshot.childSnapshot(forPath: "time").value as? String ?? ""
        self.image = withSnapshot.childSnapshot(forPath: "image").value as? String ?? ""
        self.memo = withSnapshot.childSnapshot(forPath: "memo").value as? String ?? ""
        self.isFinished = withSnapshot.childSnapshot(forPath: "isFinished").value as? Bool ?? false
        
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



//struct CatTodo {
//    var catID: Int = 0
//    var title: String
//    var time: String
//    var image: String //아이콘이름
//    var memo: String
//    var isFinished: Bool = false
//    
//}
//
//extension CatTodo {
//    static var list: [CatTodo] = [
//        CatTodo(catID: 1, title: "산이 밥주기", time: "오전 11시", image: TodoIconList[0], memo: "", isFinished: true) ,
//        CatTodo(catID: 0, title: "산이 화장실 치우기", time: "오후 10시", image: TodoIconList[2], memo: "", isFinished: false),
//        CatTodo(catID: 2, title: "산이 놀아주기", time: "오후 6시", image: TodoIconList[3], memo: "", isFinished: false),
//    ]
//    
//    static let TodoIconList: [String] = [
//        "catfood", "catsnack", "cattoilet", "catgame", "catdoctor",
//        "catpill", "catshoppingbasket", "catjelly", "catwrite"
//    ]
//    
//}