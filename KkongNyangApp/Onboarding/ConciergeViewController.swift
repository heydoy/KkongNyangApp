//
//  ConciergeViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/19.
//

import UIKit

class ConciergeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // isFirstLaunch 값에 따라 분기하여 온보딩, 또는 메인을 띄워줌
    override func viewDidAppear(_ animated: Bool) {
        if LandscapeManager.shared.isFirstLaunch {
            performSegue(withIdentifier: "toOnboarding", sender: nil)
            LandscapeManager.shared.isFirstLaunch = true
        } else {
            // 온보딩 계속 보고 싶으므로 임시로 똑같이 바꿈
            performSegue(withIdentifier: "toOnboarding", sender: nil)
            LandscapeManager.shared.isFirstLaunch = true
            //performSegue(withIdentifier: "toMain", sender: nil)
        }
    }
}
