//
//  CatPalate.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/29.
//

import Foundation
import UIKit

struct CatPalate {
    var catItem: CatItem
    var preferenceLevel: Float // 0.0 ~ 1.0 hate, don't like, average, like, like very much
}


struct CatItem {
    var itemKind: [CatItem]
    var itemImage: UIImage
    var itemName: String
    
}



enum CatItemKind {
    case food
    case snack
    case toy
    case sand
    case etc
}
