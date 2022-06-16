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
    // Firebase DB 주소
    let db: DatabaseReference! = Database.database(url: "https://kkongnyangapp-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    
    var catID: String = ""
    var todo: String = ""
    var perDay: String = ""
    var perHour: String = ""
    var perWeek: [String] = []
    var image: String = ""
    var memo : String = ""
    
    var familyCode: String = ""

    // 아울렛 변수
    @IBOutlet weak var selectTodoButton: PickerButton!
    @IBOutlet weak var selectPerDayButton: PickerButton!
    @IBOutlet weak var selectPerHourButton: PickerButton!
    
    
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayButton: UIButton!
    
 
    
    let pickerValues: [String] = Todo.TitleList
    
    let pickerValuesOfDay: [String] = [
        "1회", "2회", "3회", "4회", "5회",
        "6회", "7회", "8회", "9회", "10회"
    ]
    let pickerValeusOfHour: [String] = [
        "1시간", "2시간", "3시간", "4시간", "5시간",
        "6시간", "7시간", "8시간", "9시간", "10시간",
        "11시간", "12시간"
    ]
    
    
    var catTodo: ((CatTodo) -> Void)?
    
    
    @IBOutlet weak var todoTextField: UITextField!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 픽커버튼
        selectTodoButton.dataSource = self
        selectTodoButton.delegate = self

        
        // 버튼 처음에 보이는 글자를 픽커내용이 아니도록 설정
        selectTodoButton.setTitle("::할 일 선택::", for: .normal)
        selectPerDayButton.setTitle("하루에 몇회", for: .normal)
        selectPerHourButton.setTitle("시간 간격", for: .normal)
    
        // 버튼 둥글리기
        setAttribute()
        
        // 파이어베이스
        getFamilyCode()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("DismissAddTodoView"), object: nil, userInfo: nil)
    }
    
    // MARK: - Actions
    
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
        // 직접 작성 선택전에는 disabled
        
        let text = sender.text ?? ""
        todo = text
    }
    
    
    @IBAction func didMemoTextFieldEditingChanged(_ sender: UITextField) {
        
        let text = sender.text ?? ""
        memo = text
    }
    
    @IBAction func didAddButtonTapped(_ sender: UIButton) {
        
        
        // 버튼 텍스트로 이미지 추가
        getButtonText()
        

        
        let parent = db.child("catFamilies/\(self.familyCode)/todo")
        
        
        let post = ["catId": self.catID,
                    "title": self.todo,
                    "time" : self.perDay,
                    "image": self.image,
                    "memo": self.memo,
                    "isFinished": false ] as [String : Any]
        
        parent.childByAutoId().updateChildValues(post)
        
        // 모달 없애기
 
        self.dismiss(animated: true, completion: nil)
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
    func setAttribute(){
        let buttonArray: [UIButton] = [
        mondayButton, tuesdayButton, wednesdayButton,
        thursdayButton, fridayButton, saturdayButton,
        sundayButton
        ]
        
        buttonArray.forEach { button in
            button.layer.cornerRadius = 8
            button.setTitleColor(.greengray900!, for: .selected)
        }
    }
    
    func getButtonText(){
        let title = selectTodoButton.currentTitle!
        let text : [String] = Todo.TitleList
        for (index, t) in text.enumerated() {
            if title == t {
                self.image = Todo.IconList[index]
            }
        }
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
