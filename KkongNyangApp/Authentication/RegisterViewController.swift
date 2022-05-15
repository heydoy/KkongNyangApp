//
//  RegisterViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/08.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - Properties
    var email: String = ""
    var name: String = ""
    var password: String = ""
    var catFamilyCode: String = ""
    
    var userInfo: ((UserInfo) -> Void)?
    
    //  유효성 검사를 위한 프로퍼티
    var isValidEmail = false {
        didSet {
            self.validateUserInfo()
        }
    }

    var isValidName = false {
        didSet {
            self.validateUserInfo()
        }
    }
    
    var isValidPasssword = false  {
        didSet {
            self.validateUserInfo()
        }
    }
    
    var isValidCatFamilyCode = false  {
        didSet {
            self.validateUserInfo()
        }
    }
    
    // 텍스트필드 outlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var catFamilyCodeTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    //  computed property로 처리하기
    var textFields: [UITextField] {
        [nameTextField, emailTextField, passwordTextField, catFamilyCodeTextField]
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        
        // bug fix
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil

    }

    // MARK: - Action
    
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        
        let text = sender.text ?? ""
        
        switch sender {
        case nameTextField:
            // 글자수만 2자 이상으로 확인
            self.isValidName = text.count > 2
            self.name = text
            
        case emailTextField:
            self.isValidEmail = text.isValidEmail()
            self.email = text
            
        case passwordTextField:
            self.isValidPasssword = text.isValidPassword()
            self.password = text
            
            
        case catFamilyCodeTextField:
            self.isValidCatFamilyCode = text.isValidCatFamilyCode()
            self.catFamilyCode = text
            
        default:
            fatalError("Missing TextField")
        }
    }
    
    
    @IBAction func backButtonDidTapped(_ sender: UIBarButtonItem) {
        
        // 뒤로가기는 popViewController
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonDidTapped(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
        let userInfo = UserInfo(
            name: self.name,
            email: self.email,
            password: self.password,
            catFamilyCode: self.catFamilyCode
        )
        
        self.userInfo?(userInfo)
    }
    
    // MARK: - Helpers

    // 액션과 연결해주기위한 메소드
    private func setupTextField() {
        
        // addtarget은 해당 영역에서 이벤트가 처리되면 누가 처리할 것인가 하는 메서드
       
        textFields.forEach { tf in
            tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        }
    }
    
    // 사용자가 입력한 회원정보를 확인하고 UI 업데이트(가입 버튼 색상 변경)
    private func validateUserInfo() {
        if isValidName
            && isValidEmail
            && isValidPasssword
            && isValidCatFamilyCode{
            self.signupButton.isEnabled = true
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = UIColor.greengray900
            }
        } else {
            self.signupButton.isEnabled = false
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = UIColor.gray300
            }
        }
        
    }
    
}


// 정규표현식
extension String {
    
    func isValidPassword() -> Bool {
        // 비밀번호: 대문자 , 소문자, 특수문자, 숫자 8자 이상일 때 True
        let passwordRegEx  = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[\\d])(?=.*[~!@#\\$%\\^&\\*])[\\w~!@#\\$%\\^&\\*]{8,}$"

        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", passwordRegEx)
        
        return passwordValidation.evaluate(with: self)
    }
    
    
    func isValidEmail() -> Bool {
        // 이메일: @포함 2글자 이상
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: self)
    }
    
    func isValidCatFamilyCode() -> Bool {
        // 육묘초대코드: 영어대문자, 숫자 포함 5자
        let catFamilyCodeRegEx =
        "[A-Z-0-9]{5}"
        let catFamilyCodeValidation = NSPredicate.init(format: "SELF MATCHES %@", catFamilyCodeRegEx)
        
        return catFamilyCodeValidation.evaluate(with: self)
    }
    
}
