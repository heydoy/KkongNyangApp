//
//  PalateViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/29.
//

import UIKit

class PalateViewController: UIViewController {

    // MARK: - Propertiess
    
    @IBOutlet weak var firstCatView: UIView!
    @IBOutlet weak var secondCatView: UIView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            firstCatView.alpha = 1
            secondCatView.alpha = 0
        } else {
            firstCatView.alpha = 0
            secondCatView.alpha = 1
        }
    }
    
    @IBAction func didAddPalateButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addPalateViewController = storyboard.instantiateViewController(withIdentifier: "AddPalateVC") as! AddPalateViewController
        addPalateViewController.modalPresentationStyle = .fullScreen
        
        self.present(addPalateViewController, animated: true, completion: nil)
    }
    


}

