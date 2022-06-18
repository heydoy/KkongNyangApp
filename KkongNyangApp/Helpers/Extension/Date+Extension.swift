//
//  Date+Extension.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/18.
//

import Foundation


extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    
    }
}
