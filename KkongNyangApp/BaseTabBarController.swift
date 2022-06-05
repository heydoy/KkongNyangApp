//
//  BaseTabBarController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit

class BaseTabBarController: UITabBarController {
    @IBInspectable var defaultIndex: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = defaultIndex

    }
    



}
