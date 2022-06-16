//
//  EmailLoginViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/08.
//

import UIKit
import FirebaseAuth

class EmailLoginViewController: UIViewController {

    
    // MARK: - Properties
    var email = String()
    var password = String()
    var userInfo: UserInfo?
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttribute()
      
    }
    
    
    // MARK: - Actions

    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        // 옵셔널: 값이 없을수도, 있을수도 있다.
        let text = sender.text ?? ""
        //print("email : \(text)")
        
        self.loginButton.backgroundColor = text.isValidEmail() ?
            .greengray900 : .gray300
        
        self.email = text
    }
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""

        
        self.loginButton.backgroundColor =
            text.count > 2 ? .greengray900 : .gray300
        
        self.password = text
    }
    
    
    
    
    @IBAction func didLoginButtonTapped(_ sender: UIButton) {

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                let loginErrorAlert = UIAlertController(title: "로그인실패", message: "아이디 또는 패스워드가 일치하지 않습니다.", preferredStyle: .alert)
                let cancleAction = UIAlertAction(title: "확인", style: .destructive, handler: nil)
                loginErrorAlert.addAction(cancleAction)
                self!.present(loginErrorAlert, animated: true, completion: nil)
                
                print("에러 --> \(error.localizedDescription)")
                print("authResult --> \(authResult?.debugDescription ?? "")")
                print("아이디 또는 패스워드가 일치하지 않습니다.")
                return
            }
          guard let strongSelf = self else {
              return }
          // ...
            let storyboard = UIStoryboard.main
            let vc = storyboard.instantiateViewController(withIdentifier: "MainTabVC") as! UITabBarController
            

            if #available(iOS 15.0, *) {
                self?.view.window?.windowScene?.keyWindow?.rootViewController = vc
            } else {

                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    
    // 회원가입 버튼
    @IBAction func didRegisterButtonTapped(_ sender: UIButton) {
       
        // 화면전환
        let storyboard = UIStoryboard(name: "SignupAndLogin", bundle: nil)
        let signupViewController = storyboard.instantiateViewController(withIdentifier: "SignupFirstPageVC") as! LoginViewController

        self.navigationController?.pushViewController(signupViewController, animated: true)
        


     }
    
    // MARK: - Helpers
    func setAttribute() {
        // 가입하기 버튼 색상 변경
        
        let text1 = "계정이 없으신가요?"
        let text2 = "가입하기"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.gray300!
        let color2 = UIColor.gray700!
        
        
        let attributes = generateButtonAttribute(
            self.registerButton,
            texts: text1, text2,
            fonts: font1, font2,
            colors: color1, color2
        )
        
        self.registerButton.setAttributedTitle(attributes, for: .normal)
        
        // 로그인 버튼
        self.loginButton.layer.cornerRadius = 12

    }
    
}
    
