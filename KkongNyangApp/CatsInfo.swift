//
//  CatsInfo.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/08.
//

import Foundation
import UIKit

// 고양이가족
struct CatsFamilyInfo {
    let catFamilyCode: String // 주요키이자 외래키
    var cats: [CatsInfo] // 고양이가 추가될 수 있으므로
}

// 고양이 각자
struct CatsInfo {
    var catPhoto: UIImage //프로필 이미지를 바꿀 수 있으니까
    var catName: String
    var catGender: Gender // 성별. 열거형으로
    var catNeutered: Bool = false// 중성화여부
    var catBirthday: Date // 생년월일
    var catMemo: String
}

enum Gender {
    case female
    case male
}
