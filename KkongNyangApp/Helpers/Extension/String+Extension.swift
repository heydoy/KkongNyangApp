//
//  String+Extension.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/16.
//

import Foundation

// 정규표현식
extension String {
    
    func isValidPassword() -> Bool {
        // 비밀번호: 대문자 , 소문자, 특수문자, 숫자 8자 이상일 때 True
        let passwordRegEx  = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[\\d])(?=.*[~!@#\\$%\\^&\\*])[\\w~!@#\\$%\\^&\\*]{8,}$"

        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", passwordRegEx)
        
        return passwordValidation.evaluate(with: self)
    }
    
    
    func isValidEmail() -> Bool {
        // 이메일: @포함 2글자 이상
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: self)
    }
    
    func isValidCatFamilyCode() -> Bool {
        // 육묘초대코드: 영어대문자, 숫자 포함 5자
        let catFamilyCodeRegEx =
        "[A-Z-0-9]{5}"
        let catFamilyCodeValidation = NSPredicate.init(format: "SELF MATCHES %@", catFamilyCodeRegEx)
        
        return catFamilyCodeValidation.evaluate(with: self)
    }
    
}

extension String {
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
