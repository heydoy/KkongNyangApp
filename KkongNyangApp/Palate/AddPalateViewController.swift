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
    var catID: Int = 0
    
    @IBOutlet weak var selectKindButton: PickerButton!
    let pickerValues: [String] = CatPalate.CatItemKind
    
    let imagePickerViewController = UIImagePickerController()
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var preferenceLevelText: UILabel!
    
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
    
    
    @IBAction func didSelectCatTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            catID = 0
            break
        case 1:
            catID = 1
            break
        case 2:
            catID = 2
            break
        default:
            catID = 0
            break
        }
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
    
    @IBAction func didPreferenceLevelValueChanged(_ sender: UISlider) {
        let value = sender.value
        var text: String = ""
        
        if value < 0.2 {
            text = "싫어해요"
        } else if value >= 0.2 && value < 0.4 {
            text = "그냥 그래요"
        } else if value >= 0.4 && value < 0.6 {
            text = "괜찬아요"
        } else if value >= 0.6 && value < 0.8 {
            text = "좋아해요"
        } else if value > 0.8 {
            text = "너무 좋아해요"
        }
        
        DispatchQueue.main.async {
               self.preferenceLevelText.text = "\(text)"
               print("Slider value = \(value)")
           }

    }
    
    
    @IBAction func didAddButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
