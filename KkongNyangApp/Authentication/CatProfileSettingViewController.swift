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
    
    var catInfo:  ((CatsInfo) -> Void)?
    
    // 텍스트필드 아울렛
    @IBOutlet weak var catPhotoImageView: UIImageView!
    @IBOutlet weak var catNameTextField: UITextField!
    @IBOutlet weak var catBirthdayTextField: UITextField!
    @IBOutlet weak var catMemoTextField: UITextField!
    
    // 버튼 아울렛
    @IBOutlet weak var catGenderFemaleButton: UIButton!
    @IBOutlet weak var catGenderMaleButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    
    
    // MARK: - Helpers
    


}
