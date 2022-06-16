//
//  RegisterViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/08.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {

    // MARK: - Properties
    // 파이어베이스
    let db: DatabaseReference! = Database.database(url: "https://kkongnyangapp-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    
    // 사용자 정보
    var email: String = ""
    var name: String = ""
    var password: String = ""
    var catFamilyCode: String = ""
    
    
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
    

    @IBAction func registerButtonDidTapped(_ sender: UIButton) {
        // 파이어베이스 가입
        Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
            // 에러 발생시
            if let eror = error {
                print(eror.localizedDescription )
                return
            } else {
            // 성공적으로 유저가 가입되었을 경우
                let userData = [
                    "name" : self.name,
                    "catFamilyCode": self.catFamilyCode ]
                as [String : Any]

                self.db.child((authResult?.user.uid)!).updateChildValues(userData)
                
            // 로그인 상태로 변경
                Auth.auth().signIn(withEmail: self.email, password: self.password) { [weak self] authResult, error in
                  guard let strongSelf = self else { return }
                  // ...
                }
                
            // 고양이 프로필 입력화면으로 전환
                // 1. 스토리보드 생성
                let storyboard = UIStoryboard(name: "SignupAndLogin", bundle: nil)
                // 2. 뷰컨트롤러를 생성
                let catProfileSettingViewController = storyboard.instantiateViewController(withIdentifier: "CatProfileSettingVC") as! CatProfileSettingViewController
                // 3. 화면전환 메소드를 이용해서 화면을 전환
                self.navigationController?.pushViewController(catProfileSettingViewController, animated: true)
            }

        }
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
