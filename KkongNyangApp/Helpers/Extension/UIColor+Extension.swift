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
    static let gray80 = UIColor(named: "gray-80")
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

// 16진수를 UIColor
extension UIColor {
    convenience init(hex16: UInt16) {
            let alpha = CGFloat((hex16 >> 12) & 0xf) / 0xf
            let red = CGFloat((hex16 >> 8) & 0xf) / 0xf
            let green = CGFloat((hex16 >> 4) & 0xf) / 0xf
            let blue = CGFloat(hex16 & 0xf) / 0xf
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
        convenience init (hex32: UInt32) {
            let alpha = CGFloat((hex32 >> 24) & 0xff) / 0xff
            let red = CGFloat((hex32 >> 16) & 0xff) / 0xff
            let green = CGFloat((hex32 >> 8) & 0xff) / 0xff
            let blue = CGFloat(hex32 & 0xff) / 0xff
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
        convenience init?(hexString: String) {
            if !hexString.hasPrefix("#") {
                return nil
            }
            var hexStr = hexString
            hexStr.remove(at: hexStr.startIndex)
            switch hexStr.count {
            case 3:
                hexStr = "f" + hexStr
                fallthrough
            case 4:
                guard let hex16 = UInt16(hexStr, radix: 16) else {
                    return nil
                }
                self.init(hex16: hex16)
            case 6:
                hexStr = "ff" + hexStr
                fallthrough
            case 8:
                guard let hex32 = UInt32(hexStr, radix: 16) else {
                    return nil
                }
                self.init(hex32: hex32)
            default:
                return nil
            }
        }
}
