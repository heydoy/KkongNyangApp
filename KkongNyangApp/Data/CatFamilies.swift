//
//  CatsInfo.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/08.
//

import Foundation
import UIKit
import FirebaseDatabase

// 고양이가족
struct CatsFamily {
    let catFamilyCode: String // 주요키
    var familys: [User]
    var cats: [Cat] // 고양이가 추가될 수 있으므로
}

// 고양이 각자
class Cat {
    var birthday: String // 생년월일
    var gender: String
    var photo: String //프로필 이미지를 바꿀 수 있으니까
    var name: String
    var memo: String
    //var catNeutered: Bool = false// 중성화여부
    
    
    init(withSnapshot: DataSnapshot){
        self.birthday   = withSnapshot.childSnapshot(forPath: "birthday").value as? String ?? ""
        self.gender     = withSnapshot.childSnapshot(forPath: "gender").value as? String ?? ""
        self.photo      = withSnapshot.childSnapshot(forPath: "photo").value as? String ?? ""
        self.name       = withSnapshot.childSnapshot(forPath: "name").value as? String ?? ""
        self.memo       = withSnapshot.childSnapshot(forPath: "memo").value as? String ?? ""
    }
}



