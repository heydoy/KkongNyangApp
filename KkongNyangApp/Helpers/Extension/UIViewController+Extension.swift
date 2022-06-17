//
//  UIViewController+Extension.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/08.
//

import UIKit

extension UIViewController {
    func generateButtonAttribute(_ button: UIButton,
                                 texts: String...,
                                 fonts: UIFont...,
                                 colors: UIColor...) -> NSMutableAttributedString {
        //UIButton에 입력된 text를 가져온다.
        guard let wholeText = button.titleLabel?.text else { fatalError("버튼에 텍스트가 없음.") }
        
        // 폰트들
        let customFonts: [UIFont] = fonts
        
        // 설정하고자 하는 String의 NSRanges
        let customTextsRanges = texts.indices.map { index in
            (wholeText as NSString).range(of: texts[index])
        }
        
        // 설정하고자 하는 색상들
        let customColors = colors
        
        // Attribute 객체를 생성한다.
        let attributedString = NSMutableAttributedString(string: wholeText)
        
        // 텍스트에 맞는 설정을 추가한다.
        texts.indices.forEach { index in
            attributedString.addAttribute(.font,
                                          value: customFonts[index],
                                          range: customTextsRanges[index])
            attributedString.addAttribute(.foregroundColor,
                                          value: customColors[index],
                                          range: customTextsRanges[index])
        }
       return attributedString
    }
}

extension UIViewController {
    func showPopUp(title: String? = nil,
                   message: String? = nil,
                   attributedMessage: NSAttributedString? = nil,
                   leftActionTitle: String? = "취소",
                   rightActionTitle: String = "확인",
                   leftActionCompletion: (() -> Void)? = nil,
                   rightActionCompletion: (() -> Void)? = nil) {
        let popUpViewController = PopupViewController(titleText: title, messageText: message, attributedMessageText: attributedMessage)
        showPopUp(popUpViewController: popUpViewController,
                  leftActionTitle: leftActionTitle,
                  rightActionTitle: rightActionTitle,
                  leftActionCompletion: leftActionCompletion,
                  rightActionCompletion: rightActionCompletion)
    }

    func showPopUp(contentView: UIView,
                   leftActionTitle: String? = "취소",
                   rightActionTitle: String = "확인",
                   leftActionCompletion: (() -> Void)? = nil,
                   rightActionCompletion: (() -> Void)? = nil) {
        let popUpViewController = PopupViewController(contentView: contentView)

        showPopUp(popUpViewController: popUpViewController,
                  leftActionTitle: leftActionTitle,
                  rightActionTitle: rightActionTitle,
                  leftActionCompletion: leftActionCompletion,
                  rightActionCompletion: rightActionCompletion)
    }

    private func showPopUp(popUpViewController: PopupViewController,
                           leftActionTitle: String?,
                           rightActionTitle: String,
                           leftActionCompletion: (() -> Void)?,
                           rightActionCompletion: (() -> Void)?) {
        popUpViewController.addActionToButton(title: leftActionTitle, titleColor: .systemGray,  backgroundColor: .secondarySystemBackground) {
            popUpViewController.dismiss(animated: false, completion: leftActionCompletion)
        }

        popUpViewController.addActionToButton(title: rightActionTitle, titleColor: .white!, backgroundColor: .blue) {
            popUpViewController.dismiss(animated: false, completion: rightActionCompletion)
        }
        present(popUpViewController, animated: false, completion: nil)
    }
}
