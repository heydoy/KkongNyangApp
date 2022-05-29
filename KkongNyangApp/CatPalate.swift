//
//  CatPalate.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/29.
//

import Foundation
import UIKit

struct CatPalate {
    var itemKind: [CatItem]
    var itemImage: UIImage
    var itemName: String
    var preferenceLevel: Float // 0.0 ~ 1.0 hate, don't like, average, like, like very much
    
}

enum CatItem {
    case food
    case snack
    case toy
    case sand
    case etc
}
