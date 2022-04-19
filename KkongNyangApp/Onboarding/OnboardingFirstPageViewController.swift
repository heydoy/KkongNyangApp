//
//  OnboardingFirstPageViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/19.
//

import UIKit

class OnboardingFirstPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 버튼이 눌리면 다음 페이지로 가기
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        if let pageController = parent as? OnboardingPageViewController {
            pageController.pushNext()
        }
    }
    
}
