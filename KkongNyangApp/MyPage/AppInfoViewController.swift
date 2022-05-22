//
//  AppInfoViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/22.
//

import UIKit

class AppInfoViewController: UIViewController {

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    // MARK: - Action
    
    @IBAction func didBackButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    


}
