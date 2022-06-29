//
//  AddTodoViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit
import PickerButton
import FirebaseAuth
import FirebaseDatabase

class AddTodoViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    
    
    // Firebase DB 주소
    let db: DatabaseReference! = Database.database(url: "https://kkongnyangapp-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    var familyCode: String = ""
    
    
    var catID: String = ""
    var todo: String = ""
    var time: String = "매일 오전 10시"

    var image: String = ""
    var memo : String = ""

    

    // 아울렛 변수
    // 아울렛 텍스트필드
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var timeTextFielld: UITextField!
    
    // 선택버튼
    @IBOutlet weak var selectTodoButton: PickerButton!

    
    
    
    let pickerValues: [String] = Todo.TitleList
    
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 픽커버튼
        selectTodoButton.dataSource = self
        selectTodoButton.delegate = self

        
        // 버튼 처음에 보이는 글자를 픽커내용이 아니도록 설정
        selectTodoButton.setTitle("::할 일 선택::", for: .normal)


        
        // 파이어베이스
        getFamilyCode()
        
        // 전달될 경우
        if isEditing == true {
           
           setView()
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("DismissAddTodoView"), object: nil, userInfo: nil)
    }
    
    // MARK: - Actions
    
    
    @IBAction func didSelectButtonEditingChanged(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.getButtonText()
            self.titleTextField.text = self.title
        }
    }
    
    
    @IBAction func didDismissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didSelectCatTapped(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            // 공통
            catID = "0"
            break
        case 1:
            // 첫째고양이
            catID = "1"
            break
        default:
            // nil
            break
        }
    }
    
    @IBAction func didTodoTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.todo = text
    }
    
    @IBAction func didTimeTextFieldEditingChanged(_ sender: UITextField) {
        
        let text = sender.text ?? ""
        self.time = text
    }
    
    
    
    @IBAction func didMemoTextFieldEditingChanged(_ sender: UITextField) {
        
        let text = sender.text ?? ""
        self.memo = text
    }
    
    @IBAction func didAddButtonTapped(_ sender: UIButton) {
        
        
        // 버튼 텍스트로 이미지 추가
        getButtonText()

        
        showPopUp(title: "할 일 추가", message: "할일 \(self.todo)을(를) 추가하시겠습니까?", attributedMessage: NSAttributedString(string: "할일 \(self.todo)을(를) 추가하시겠습니까?"), leftActionTitle: "취소", rightActionTitle: "추가") {
            // 취소일 경우 아무것도 하지 않음
        } rightActionCompletion: {
            let parent = self.db.child("catFamilies/\(self.familyCode)/todo")
            
            
            let post = ["catId": self.catID,
                        "title": self.todo,
                        "time" : self.time,
                        "image": self.image,
                        "memo": self.memo,
                        "isFinished": false,
                        "finishTime": ""
            ] as [String : Any]
            
            parent.childByAutoId().updateChildValues(post)
            
            self.dismiss(animated: true, completion: nil)

        }

    }
    
    
    
    
    @IBAction func setButtonState(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = UIColor.yellow500!
            

        } else {
            sender.backgroundColor = UIColor.gray80
        }
        
    }

    // MARK: - Helpers
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
    }

    
    func setView() {
        titleTextField.text = self.todo
        memoTextField.text = self.memo
        timeTextFielld.text = self.time
        selectTodoButton.setTitle(imageToButtonText(), for: .normal)
        
        viewTitle.text = "할 일 수정하기"
        viewButton.setTitle("수정하기", for: .normal)
    }
    
    func getButtonText() {
        let title = selectTodoButton.currentTitle!
        let text : [String] = Todo.TitleList
        for (index, t) in text.enumerated() {
            if title == t {
                self.image = Todo.IconList[index]
            }
        }
    }
    
    func imageToButtonText() -> String {
        var text = ""
        let icon: [String] = Todo.IconList
        for (index, i) in icon.enumerated() {
            if i == self.image {
                text = Todo.TitleList[index]
            }
        }
        return text
    }
}

// MARK: - Extensions

extension AddTodoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
