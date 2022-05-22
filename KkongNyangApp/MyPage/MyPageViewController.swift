//
//  MyPageViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/22.
//

import UIKit

class MyPageViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Action
    @IBAction func didMyProfileButtonTapped(_ sender: UIButton) {
        print("집사프로필")
    }
    
    @IBAction func didCatProfileButtonTapped(_ sender: UIButton) {
        print("고양이프로필")
    }
    
    @IBAction func didAlertSettingButtonTapped(_ sender: UIButton) {
        //print("알림설정")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let alertSettingViewController = storyboard.instantiateViewController(withIdentifier: "AlertSettingVC") as! AlertSettingViewController
        self.navigationController?.pushViewController(alertSettingViewController, animated: true)
    }
    
    
    @IBAction func didAppInfoButtonTapped(_ sender: UIButton) {
        //print("앱정보")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let appInfoViewController = storyboard.instantiateViewController(withIdentifier: "AppInfoVC") as! AppInfoViewController
        self.navigationController?.pushViewController(appInfoViewController, animated: true)
    }
    
    
}
