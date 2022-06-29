//
//  AddPalateViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit
import PickerButton
import FirebaseAuth
import FirebaseDatabase

class AddPalateViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    
    
    let db: DatabaseReference! = Database.database(url: "https://kkongnyangapp-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    var familyCode: String = ""
    var userName: String = ""
    
    
    var catID: String = "0"
    var history: String = "" // 내가 4월 7일 기록
    var preferenceLevel: Double = 0.0
    var itemKind: String = ""
    var itemName: String = ""
    var itemImage: String = "sample-palate-3" // 빈 이미지
    var memo: String = ""
    
    @IBOutlet weak var selectKindButton: PickerButton!
    let pickerValues: [String] = Palate.CatItemKind
    
    @IBOutlet weak var addPalateButton: UIButton!
    
    let imagePickerViewController = UIImagePickerController()
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var preferenceLevelText: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var likeSlider: UISlider!
    @IBOutlet weak var memoTextField: UITextField!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttribute()
        
        selectKindButton.dataSource = self
        selectKindButton.delegate = self
        
        imagePickerViewController.delegate = self
        
        getFamilyCode()
        
        if isEditing == true {
           
           setView()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 알림제어 (이걸 통해서 돌아가는 화면을 새로고침할 것)
        NotificationCenter.default.post(name: NSNotification.Name("DismissAddPalateView"), object: nil, userInfo: nil)
        
    }
    
    // MARK: - Actions
    @IBAction func didDismissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didSelectCatTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            catID = "0"
            break
        case 1:
            catID = "1"
            break
        default:
            catID = "0"
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
    
    
    @IBAction func DidNameTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.itemName = text
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
           }
        preferenceLevel = Double(value)

    }
    
    @IBAction func didMemoTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.memo = text
    }
    
    
    @IBAction func didAddButtonTapped(_ sender: Any) {
        
        
        showPopUp(title: "기호 추가", message: "", attributedMessage: NSAttributedString(string: "\(itemName) 을 추가하시겠습니까?"), leftActionTitle: "취소", rightActionTitle: "추가") {
            // 취소일 경우 아무것도 하지 않음
        } rightActionCompletion: {
            let parent = self.db.child("palates/\(self.familyCode)")
            
            let post = [
                "catID" : self.catID,
                "kind" : self.getButtonText(),
                "image" : self.itemImage,
                "name" : self.itemName,
                "like" : self.preferenceLevel,
                "memo" : self.memo,
                "history" : self.setHistory()
            ] as [String : Any]
            
            parent.childByAutoId().updateChildValues(post)
            
            self.dismiss(animated: true, completion: nil)
        }
        
        
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
        // 이미지뷰
        productImage.layer.cornerRadius = 20
        // 버튼
        selectKindButton.setTitle(":: 기호종류 선택 ::", for: .normal)
        selectKindButton.layer.cornerRadius = 10
        addPalateButton.layer.cornerRadius = 10
    }
    
    func setHistory() -> String {
        let nowDate = Date() // 현재의 Date (ex: 2020-08-13 09:14:48 +0000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일 h시" // 2020-08-13 16:30
        let str = dateFormatter.string(from: nowDate) // 현재 시간의 Date를 format에 맞춰 string으로 반환
        return "\(self.userName) 님이 \(str) 기록"
    }
    
    func getButtonText() -> String {
            let title = selectKindButton.currentTitle!
            return title
    }
    
    func getFamilyCode() {
        // firebasse
        let user = Auth.auth().currentUser
        var uid = ""
        if let user = user {
            uid = user.uid
        }
        

        self.db.child("users/\(uid)/catFamilyCode").getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self.familyCode = (snapshot?.value as? String)!
        }
        
        self.db.child("users/\(uid)/name").getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self.userName = (snapshot?.value as? String)!
        }
        
        
    }
    
    func setView() {
        selectKindButton.setTitle(self.itemKind, for: .normal)
        productImage.image = UIImage(named: self.itemImage)
        nameTextField.text = self.itemName
        likeSlider.setValue(Float(self.preferenceLevel), animated: false)
        memoTextField.text = self.memo
        viewTitle.text = "기호 수정하기"
        viewButton.setTitle("수정하기", for: .normal)
        
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
