//
//  CatTodo.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/03.
//

import Foundation
import UIKit


struct CatTodo {
    var catID: Int = 0
    var title: String
    var time: String
    var image: String //아이콘이름
    var isFinished: Bool = false
    var date: [String] //date 중에 고르기
}

let TodoTitleList: [String] = [
    "식사주기", "간식주기", "화장실청소", "놀아주기", "병원가기",
    "약 먹이기", "고양이용품 구매", "발톱깎이기 & 귀청소", "기타"
]

let date: [String] = [
    "월", "화", "수", "목", "금", "토", "일"
]

let TodoIconList: [String] = [
    "catfood", "catsnack", "cattoilet", "catgame", "catdoctor", "catpill", "catshoppingbasket", "catjelly", "catwrite"
]



extension CatTodo {
    static let list: [CatTodo] = [
        CatTodo(catID: 1, title: "산이 밥주기", time: "오전 11시", image: TodoIconList[0], isFinished: false, date: [date[0], date[2]]) ,
        CatTodo(catID: 0, title: "산이 화장실 치우기", time: "오후 10시", image: TodoIconList[2], isFinished: false, date: [date[0], date[2], date[4]]),
        CatTodo(catID: 2, title: "산이 놀아주기", time: "오후 6시", image: TodoIconList[3], isFinished: false, date: [date[0], date[2]]),
    ]
}
