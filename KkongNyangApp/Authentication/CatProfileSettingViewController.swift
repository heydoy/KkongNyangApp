//
//  CatProfileSettingViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/15.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CatProfileSettingViewController: UIViewController {
    // MARK: - Properties
    // 파이어베이스
    // 파이어베이스
    let db: DatabaseReference! = Database.database(url: "https://kkongnyangapp-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    
    var catPhoto: String = ""
    var catName: String = ""
    var catGender: String = ""
    var catMemo: String = ""
    var catBirthday: String = ""
    
    var familyCode: String = ""
    
    var indexOfButtonArray: Int? = nil
    
    
    
    let imagePickerViewController = UIImagePickerController()

    // 이미지뷰, 텍스트필드 아울렛
    @IBOutlet weak var catPhotoImageView: UIImageView!
    
    @IBOutlet weak var catNameTextField: UITextField!
    @IBOutlet weak var catBirthdayTextField: UITextField!
    @IBOutlet weak var catMemoTextField: UITextField!
    
    // computed property로 처리하기
    var textFields: [UITextField] {
        [catNameTextField, catBirthdayTextField, catMemoTextField]
    }
    
    // 버튼 아울렛
    
    @IBOutlet var genderRadioButtons: [UIButton]!
    
    @IBOutlet weak var finishButton: UIButton!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        setupTextField()
        
        imagePickerViewController.delegate = self
    }
    
    // MARK: - Actions
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender {
        case catNameTextField:
            // 글자수 한글자 이상
            self.catName = text
            
        case catBirthdayTextField:
            self.catBirthday = text
            
        case catMemoTextField:
            self.catMemo = text
            
        default:
            fatalError("Missing Textfield")
        }
    }
    
    
    @IBAction func didButtonTapped(_ sender: UIButton) {
        if indexOfButtonArray != nil {
            if !sender.isSelected {
                for index in genderRadioButtons.indices {
                    genderRadioButtons[index].isSelected = false
                }
                sender.isSelected = true
                indexOfButtonArray = genderRadioButtons.firstIndex(of: sender)
            } else {
                sender.isSelected = false
                indexOfButtonArray = nil
            }
        } else {
            sender.isSelected = true
            indexOfButtonArray = genderRadioButtons.firstIndex(of: sender)
        }
        
        if indexOfButtonArray == 0 {
            catGender = "female"
        } else {
            catGender = "male"
        }
    }
    
    
    @IBAction func buttonGoImagePicker(_ sender: Any) {
        let alert =  UIAlertController(title: "고양이 사진", message: "고양이 사진을 찍거나 선택해주세요.", preferredStyle: .actionSheet)


        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
        }


        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)

//        self.present(imagePickerViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func didFinishButtonTapped(_ sender: UIButton) {
        
        
        // 고양이 데이터 저장하기
        let catData = [
            "name" : self.catName,
            "photo" : self.catPhoto,
            "gender" : self.catGender,
            "birthday": self.catBirthday,
            "memo": self.catMemo
        ] as [String : Any]
        
        self.db.child("catFamilies/\(self.familyCode)/cat/01").updateChildValues(catData)
        
        
        // 가족초대화면으로 이동
        
        let storyboard = UIStoryboard(name: "SignupAndLogin", bundle: nil)
        
        let butlerInvitationVC = storyboard.instantiateViewController(withIdentifier: "ButlerInvitationViewController") as! ButlerInvitationViewController
        
        butlerInvitationVC.familyCode = self.familyCode
        butlerInvitationVC.catName = self.catName
        
        self.navigationController?.pushViewController(butlerInvitationVC, animated: true)
 
    }
    
    
    
    // MARK: - Helpers
    func openLibrary(){

    imagePickerViewController.sourceType = .photoLibrary
      present(imagePickerViewController, animated: false, completion: nil)

    }

    func openCamera(){

    imagePickerViewController.sourceType = .camera
      present(imagePickerViewController, animated: false, completion: nil)
    }
    
    func setAttribute() {
        catPhotoImageView.layer.cornerRadius = 20
    }
    
    // 액션과 연결해주기위한 메소드
    private func setupTextField() {
        
        // addtarget은 해당 영역에서 이벤트가 처리되면 누가 처리할 것인가 하는 메서드
       
        textFields.forEach { tf in
            tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        }
    }

}

// MARK: - Extensions
extension CatProfileSettingViewController : UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // print(info)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            catPhotoImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
