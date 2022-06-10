//
//  AddTodoViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit
import PickerButton

class AddTodoViewController: UIViewController {
    // MARK: - Properties
    var catID: Int = 0
    var todo: String = ""
    var perDay: String = ""
    var perHour: String = ""
    var perWeek: [String] = []
    var image: String = ""
    var memo : String = ""
    
    @IBOutlet weak var selectTodoButton: PickerButton!
    let pickerValues: [String] = CatTodo.TodoTitleList
    
    var catTodo: ((CatTodo) -> Void)?
    
    
    @IBOutlet weak var todoTextField: UITextField!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 픽커버튼
        selectTodoButton.dataSource = self
        selectTodoButton.delegate = self
        
        //
        selectTodoButton.setTitle("::할 일 선택::", for: .normal)

    }
    
    // MARK: - Actions
    
    @IBAction func didDismissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didSelectCatTapped(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            // 공통
            break
        case 1:
            // 첫째고양이
            break
        case 2:
            // 둘째고양이
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
        
        self.navigationController?.popViewController(animated: true)
        
        let catTodo = CatTodo(
            catID: self.catID,
            title: self.todo,
            time: self.perDay,
            image: self.image,
            isFinished: false
        )
        
        self.catTodo?(catTodo)
        
    }
    
    
    // MARK: - Helpers

    
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
