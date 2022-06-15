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
//        // 회원가입 정보를 전달받아서 그것과 Text Field 데이터가 일치하면 로그인이 되어야 한다.
//        guard let userInfo = self.userInfo else {
//            print("userInfo에 가입된 정보가 없습니다.")
//            return
//        }  // userInfo에 정보가 없으면 로그인버튼이 실행 안됨.
//
        // 아이디, 비밀번호 확인
//        if userInfo.email == self.email
//            && userInfo.password == self.password {
            // print("다음화면으로 이동")
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else {
              let loginErrorAlert = UIAlertController(title: "로그인실패", message: "아이디 또는 패스워드가 일치하지 않습니다.", preferredStyle: .alert)
              let cancleAction = UIAlertAction(title: "확인", style: .destructive, handler: nil)
              loginErrorAlert.addAction(cancleAction)
              self!.present(loginErrorAlert, animated: true, completion: nil)
              
              print("에러 --> \(error.debugDescription)")
              print("authResult --> \(authResult?.debugDescription ?? "")")
              print("아이디 또는 패스워드가 일치하지 않습니다.")
              
              return }
          // ...
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainTabVC") as! UITabBarController
            

            if #available(iOS 15.0, *) {
                self?.view.window?.windowScene?.keyWindow?.rootViewController = vc
            } else {

                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true, completion: nil)
            }
            
        }

            
    }
    
    
    
    @IBAction func didRegisterButtonTapped(_ sender: UIButton) {
       
        // 화면전환
        // 1. 스토리보드 생성
        let storyboard = UIStoryboard(name: "SignupAndLogin", bundle: nil)
        // 2. 뷰컨트롤러를 생성
        let signupViewController = storyboard.instantiateViewController(withIdentifier: "SignupFirstPageVC") as! LoginViewController
        // 3. 화면전환 메소드를 이용해서 화면을 전환
//        self.present(registerViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(signupViewController, animated: true)
        
        /*
        // new - SNS 로그인으로 연결 
        // 회원가입 화면에서 정보를 전달받을 것
        // 클로저를 사용할  때는 참조에 대한 문제가 생길 수 있으므로 [weak self] 와 self? 옵셔널을 작성해준다.
        // ARC 개념에 대해 알아두면 도움이 될 것. SWIFT에서 처리하는 메모리 관리 방식 중 한가지
        // ARC - 강한 참조는 뷰 컨트롤러가 해제되도 메모리에 남아있어서 메모리 누수의 우려가 생김./약한 참조는 ARC 낮춰줌.
        registerViewController.userInfo = { [weak self](userInfo) in
            //print(userInfo)
            self?.userInfo = userInfo
         */

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
    
