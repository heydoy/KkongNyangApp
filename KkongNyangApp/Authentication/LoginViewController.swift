//
//  LoginViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/08.
//

import UIKit


class LoginViewController: UIViewController {

    // MARK: - Properties
    var userInfo: UserInfo?
    
    @IBOutlet weak var emailSignupButton: UIButton!
    @IBOutlet weak var appleSignupButton: UIButton!
    @IBOutlet weak var kakaoSignupButton: UIButton!
    @IBOutlet weak var naverSignupButton: UIButton!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttribute()
    }
    
    // MARK: - Actions
    
    @IBAction func registerButtonDidTapped(_ sender: UIButton) {
        // 화면전환
        // 1. 스토리보드 생성
        let storyboard = UIStoryboard(name: "SignupAndLogin", bundle: nil)
        // 2. 뷰컨트롤러를 생성
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        // 3. 화면전환 메소드를 이용해서 화면을 전환
//        self.present(registerViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(registerViewController, animated: true)
        
    }
    
    @IBAction func emailLoginButtonDidTapped(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "SignupAndLogin", bundle: nil)
        let emailLoginViewController = storyboard.instantiateViewController(withIdentifier: "EmailLoginVC") as! EmailLoginViewController
        
        self.navigationController?.pushViewController(emailLoginViewController, animated: true)
    }
    
    // MARK: - Helper
    func setAttribute() {
        let buttonArray: [UIButton] = [
            emailSignupButton, appleSignupButton,
            kakaoSignupButton, naverSignupButton
        ]
        buttonArray.forEach {
            $0.layer.cornerRadius = 12
        }
    }
    

}
