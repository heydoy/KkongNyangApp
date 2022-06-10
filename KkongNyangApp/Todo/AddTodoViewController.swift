//
//  AddTodoViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit

class AddTodoViewController: UIViewController {
    // MARK: - Properties
    var catID: Int = 0
    var todo: String = ""
    var perDay: String = ""
    var perHour: String = ""
    var perWeek: [String] = []
    var image: String = ""
    var memo : String = ""
    
    var catTodo: ((CatTodo) -> Void)?
    
    
    @IBOutlet weak var todoTextField: UITextField!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

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
