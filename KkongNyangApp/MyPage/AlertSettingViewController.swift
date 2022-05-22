//
//  AlertSettingViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/22.
//

import UIKit

class AlertSettingViewController: UIViewController {
    // MARK: - Properties


    var isAlertActivated: Bool = true
    var isSleepingModeActivated: Bool = true
    
    // Button Outlet
    @IBOutlet weak var buttonAlert: UIButton!
    
    @IBOutlet weak var buttonSleepingMode: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
    }
    
    // MARK: - Action

    
    @IBAction func didAlertButtonTapped(_ sender: Any) {
        isAlertActivated = !isAlertActivated
        setAttribute()
        
    }
    

    @IBAction func didSleepingButtonTapped(_ sender: Any) {
        isSleepingModeActivated = !isSleepingModeActivated
        setAttribute()
        
        
    }
    
    @IBAction func didBackButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    private func setAttribute() {
        
        // 알림 버튼
        if isAlertActivated {
            buttonAlert.isSelected = true
        } else {
            buttonAlert.isSelected = false
        }
        
        //취침시간 버튼
        if isSleepingModeActivated {
            buttonSleepingMode.isSelected = true
        } else {
            buttonSleepingMode.isSelected = false
        }
    }
    

}
