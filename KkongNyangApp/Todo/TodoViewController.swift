//
//  TodoViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/29.
//

import UIKit

class TodoViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            firstView.alpha = 1
            secondView.alpha = 0
            thirdView.alpha = 0
        } else if sender.selectedSegmentIndex == 1 {
            firstView.alpha = 0
            secondView.alpha = 1
            thirdView.alpha = 0
        } else {
            firstView.alpha = 0
            secondView.alpha = 0
            thirdView.alpha = 1
        }
    }
    
    // MARK: - Helpers
}
