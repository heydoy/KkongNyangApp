//
//  OnboardingThirdPageViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/19.
//

import UIKit
import SwiftGifOrigin

class OnboardingThirdPageViewController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        
    }
    // 메인으로 연결할 것이므로 버튼에 액션을 달지 않음
    
    // MARK: - Helpers
    func setAttribute() {
        startButton.layer.cornerRadius = 20
        // gif
        image.loadGif(name: "onboarding-3-gif")
    }
}
