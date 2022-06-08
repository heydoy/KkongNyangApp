//
//  EmailLoginViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/08.
//

import UIKit

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
        //setupAttribute()
      
    }
    
    
    // MARK: - Actions

    @IBAction func didRegisterButtonTapped(_ sender: Any) {
       
        // 화면전환
        // 1. 스토리보드 생성
        let storyboard = UIStoryboard(name: "SignupAndLogin", bundle: nil)
        // 2. 뷰컨트롤러를 생성
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        // 3. 화면전환 메소드를 이용해서 화면을 전환
//        self.present(registerViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    
    // MARK: - Helpers
    func setupAttribute(){
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
    }
}
