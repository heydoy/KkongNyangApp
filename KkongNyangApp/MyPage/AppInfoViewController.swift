//
//  AppInfoViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/22.
//

import UIKit
import SafariServices
import AcknowList


class AppInfoViewController: UIViewController {

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    // MARK: - Action
    
    @IBAction func didBackButtonTapped(_ sender: UIButton) {
//        self.view.layoutIfNeeded()

        self.navigationController?.popViewController(animated: true)
        viewWillAppear(true)

    }
    
    
    @IBAction func didTermsOfServiceButtonTapped(_ sender: UIButton) {
        
        guard let url = URL(string: "https://kimdee.notion.site/5bf0498b615749e683e7678aea3fe720") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    @IBAction func didOpenSourceLicenseButtonTapped(_ sender: UIButton) {
        
        let acknowList = AcknowListViewController(fileNamed: "Pods-KkongNyangApp-acknowledgements")
        self.navigationController?.pushViewController(acknowList, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        
    }
    
    
    @IBAction func didPrivacyPolicyButtonTapped(_ sender: UIButton) {
        guard let url = URL(string: "https://kimdee.notion.site/26c37dff0def4e9197f2b6c3d82e7c00") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    

}
