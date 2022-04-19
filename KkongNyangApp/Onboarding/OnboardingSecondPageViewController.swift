//
//  OnboardingSecondPageViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/19.
//

import UIKit

class OnboardingSecondPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 버튼이 눌리면 다음 페이지로 가기
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        if let pageController = parent as? OnboardingPageViewController {
            pageController.pushNext()
        }
    }

}