//
//  UIColor+Extension.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/18.
//

import Foundation
import UIKit

// 커스텀 컬러
extension UIColor {
    // --> White
    static let white = UIColor(named: "white")

    // --> Grayscale
    static let gray100 = UIColor(named: "gray-100")
    static let gray200 = UIColor(named: "gray-200")
    static let gray300 = UIColor(named: "gray-300")
    static let gray500 = UIColor(named: "gray-500")
    static let gray700 = UIColor(named: "gray-700")
    
    // --> GreenGray
    // Using for Light Button Color
    static let greengray100 = UIColor(named: "greengray-100")
    // Using for Font Color Primarily
    static let greengray700 = UIColor(named: "greengray-700")
    static let greengray900 = UIColor(named: "greengray-900") // Dark Button Colors and Texts
    
    
    // --> Tinted Background Color for {Splash, Signup, Cats' Profiles)
    static let yellow100 = UIColor(named: "yellow-100")
    static let yellow150 = UIColor(named: "yellow-150")
    
    // --> Primary Color
    static let yellow500 = UIColor(named: "yellow-500")
}

// Selected Tab Bar Item Background
//extension UIImage {
//    class func imageWithColor(color: UIColor) -> UIImage {
//        let size = CGSize(width: CGFloat(50), height: CGFloat(50))
//        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        color.setFill()
//        UIRectFill(rect)
//        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return image
//    }
//}
