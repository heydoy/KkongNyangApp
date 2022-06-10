//
//  CatProfileSettingViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/15.
//

import UIKit

class CatProfileSettingViewController: UIViewController {
    // MARK: - Properties
    var catName: String = ""
    var catMemo: String = ""
    var indexOfButtonArray: Int? = nil
    
    var catInfo:  ((CatInfo) -> Void)?
    
    let imagePickerViewController = UIImagePickerController()

    // 이미지뷰, 텍스트필드 아울렛
    @IBOutlet weak var catPhotoImageView: UIImageView!
    
    @IBOutlet weak var catNameTextField: UITextField!
    @IBOutlet weak var catBirthdayTextField: UITextField!
    @IBOutlet weak var catMemoTextField: UITextField!
    
    // 버튼 아울렛
    
    @IBOutlet var genderRadioButtons: [UIButton]!
    
    @IBOutlet weak var finishButton: UIButton!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        
        imagePickerViewController.delegate = self
    }
    
    // MARK: - Actions
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
