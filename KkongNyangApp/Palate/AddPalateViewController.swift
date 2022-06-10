//
//  AddPalateViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit
import PickerButton

class AddPalateViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var selectKindButton: PickerButton!
    let pickerValues: [String] = CatPalate.CatItemKind
    
    let imagePickerViewController = UIImagePickerController()
    
    @IBOutlet weak var productImage: UIImageView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttribute()
        
        selectKindButton.dataSource = self
        selectKindButton.delegate = self
        
        imagePickerViewController.delegate = self

    }
    
    // MARK: - Actions
    @IBAction func didDismissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonGoImagePicker(_ sender: Any) {
        let alert = UIAlertController(title: "제품사진", message: "제품 사진을 찍거나 선택해주세요.", preferredStyle: .actionSheet)
        
        let library = UIAlertAction(title: "사진앨범", style: .default) { (action) in
            self.openLibrary()
        }
        
        let camera = UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Helpers
    
    func openLibrary() {
        imagePickerViewController.sourceType = .photoLibrary
        present(imagePickerViewController, animated: false, completion: nil)
    }
    
    func openCamera() {
        imagePickerViewController.sourceType = .camera
        present(imagePickerViewController, animated: false, completion: nil)
    }
    
    func setAttribute() {
        productImage.layer.cornerRadius = 20
    }
}


// MARK: - Extensions

extension AddPalateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
    
}

extension AddPalateViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image =
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // 이미지 위치시켜주기
            productImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
