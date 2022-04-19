//
//  OnboardingPageViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/19.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {

    // MARK: - UI Elements
    private var viewControllerList: [UIViewController] {
        let storyboard = UIStoryboard.onboarding
        let firstVC = storyboard.instantiateViewController(withIdentifier: "OnboardingFirstVC")
        let secondVC = storyboard.instantiateViewController(withIdentifier: "OnboardingSecondVC")
        let thirdVC = storyboard.instantiateViewController(withIdentifier: "OnboardingThirdVC")
        
        return [firstVC, secondVC, thirdVC]
    }
    
    // MARK: - Properties
    private var currentIndex = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewControllers([viewControllerList[0]], direction: .forward, animated: false, completion: nil)
    }
    
    // MARK: - Functions
    func pushNext() {
        if currentIndex + 1 < viewControllerList.count {
            self.setViewControllers([self.viewControllerList[self.currentIndex + 1]], direction: .forward, animated: true, completion: nil)
            currentIndex += 1
        }
    }
}
