//
//  CatTodo.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/03.
//

import Foundation
import UIKit


struct CatTodo {
    var catID: Int
    var title: String
    var time: TimeZone
    var image: String //아이콘이름
    var isFinished: Bool
    var date: String //date 중에 고르기
}

let TodoTitleList: [String] = [
    "식사주기", "간식주기", "화장실청소", "놀아주기", "병원가기",
    "약 먹이기", "고양이용품 구매", "발톱깎이기 & 귀청소", "기타"
]

let date: [String] = [
    "월", "화", "수", "목", "금", "토", "일"
]
