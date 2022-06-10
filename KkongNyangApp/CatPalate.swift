//
//  CatPalate.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/29.
//

import Foundation
import UIKit

//struct CatPalate {
//    var catItem: CatItem
//    var preferenceLevel: Float // 0.0 ~ 1.0 hate, don't like, average, like, like very much
//}
//

struct CatPalate {
    var catID: Int = 0
    var itemKind: String
    var itemImage: String //image url
    var itemName: String
    var preferenceLevel: Float // 0.0 ~ 1.0 hate, don't like, average, like, like very much
    var memo: String
    var history: String
    
    
}



extension CatPalate {
    static let list: [CatPalate] = [
        CatPalate(catID: 1, itemKind: CatItemKind[0], itemImage: "sample-palate-1", itemName: "로얄캐닌 센서리필 젤리파우치", preferenceLevel: 0.66, memo: "잘 먹는편", history: "동생 님이 4월 7일 기록"),
        CatPalate(catID: 2, itemKind: CatItemKind[1], itemImage: "sample-palate-2", itemName: "챠오츄르 가다랑어맛", preferenceLevel: 1.0, memo: "안 남기고 전부 먹으면서 냥냥댐",  history: "엄마 님이 1월 16일 기록"),
        CatPalate(catID: 1, itemKind: CatItemKind[2], itemImage: "sample-palate-3", itemName: "다이소 쥐 장난감", preferenceLevel: 0.3, memo: "3분 놀다가 관심도 안 줌",  history: "동생 님이 어제 기록"),
        CatPalate(catID: 1, itemKind: CatItemKind[3], itemImage: "sample-palate-4", itemName: "더스트프리 벤토나이트 파인",  preferenceLevel: 0.0, memo: "잘 안 묻고 싫어함", history: "내가 방금 기록"),
    
    ]
    
    static let CatItemKind: [String] = [
        "음식", "간식",
        "장난감", "모래",
        "기타"
    ]
}
