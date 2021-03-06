//
//  CatPalate.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/29.
//

import Foundation
import UIKit
import FirebaseDatabase

class Palate {
    var catID = ""
    var kind = ""
    var image = ""
    var name = ""
    var like = 0.0
    var memo = ""
    var history = ""
    
    init(withSnapshot: DataSnapshot) {
        self.catID = withSnapshot.childSnapshot(forPath: "catID").value as? String ?? ""
        self.kind = withSnapshot.childSnapshot(forPath: "kind").value as? String ?? ""
        self.image = withSnapshot.childSnapshot(forPath: "image").value as? String ?? ""
        self.name = withSnapshot.childSnapshot(forPath: "name").value as? String ?? ""
        self.like = withSnapshot.childSnapshot(forPath: "like").value as? Double ?? 0.0
        self.memo = withSnapshot.childSnapshot(forPath: "memo").value as? String ?? ""
        self.history = withSnapshot.childSnapshot(forPath: "history").value as? String ?? ""
    }
    
}

extension Palate {
    static let CatItemKind: [String] = [
        "๐ ์์", "๐ฐ ๊ฐ์",
        "๐งธ ์ฅ๋๊ฐ", "๐ ๋ชจ๋",
        "๐ธ ๊ธฐํ"
    ]
}









//struct CatPalate {
//    var catID: Int = 0
//    var itemKind: String
//    var itemImage: String //image url
//    var itemName: String
//    var preferenceLevel: Double // 0.0 ~ 1.0 hate, don't like, average, like, like very much
//    var memo: String
//    var history: String
//
//}
//
//
//
//extension CatPalate {
//    static let list: [CatPalate] = [
//        CatPalate(catID: 1, itemKind: CatItemKind[0], itemImage: "sample-palate-1", itemName: "๋ก์์บ๋ ์ผ์๋ฆฌํ ์ ค๋ฆฌํ์ฐ์น", preferenceLevel: 0.66, memo: "์ ๋จน๋ํธ", history: "๋์ ๋์ด 4์ 7์ผ ๊ธฐ๋ก"),
//        CatPalate(catID: 2, itemKind: CatItemKind[1], itemImage: "sample-palate-2", itemName: "์ฑ ์ค์ธ๋ฅด ๊ฐ๋ค๋์ด๋ง", preferenceLevel: 1.0, memo: "์ ๋จ๊ธฐ๊ณ  ์ ๋ถ ๋จน์ผ๋ฉด์ ๋ฅ๋ฅ๋",  history: "์๋ง ๋์ด 1์ 16์ผ ๊ธฐ๋ก"),
//        CatPalate(catID: 1, itemKind: CatItemKind[2], itemImage: "sample-palate-3", itemName: "๋ค์ด์ ์ฅ ์ฅ๋๊ฐ", preferenceLevel: 0.3, memo: "3๋ถ ๋๋ค๊ฐ ๊ด์ฌ๋ ์ ์ค",  history: "๋์ ๋์ด ์ด์  ๊ธฐ๋ก"),
//        CatPalate(catID: 1, itemKind: CatItemKind[3], itemImage: "sample-palate-4", itemName: "๋์คํธํ๋ฆฌ ๋ฒคํ ๋์ดํธ ํ์ธ",  preferenceLevel: 0.0, memo: "์ ์ ๋ฌป๊ณ  ์ซ์ดํจ", history: "๋ด๊ฐ ๋ฐฉ๊ธ ๊ธฐ๋ก"),
//
//    ]
//
//    static let CatItemKind: [String] = [
//        "๐ ์์", "๐ฐ ๊ฐ์",
//        "๐งธ ์ฅ๋๊ฐ", "๐ ๋ชจ๋",
//        "๐ธ ๊ธฐํ"
//    ]
//}
