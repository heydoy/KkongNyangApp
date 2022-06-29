//
//  NoticeDetailViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/28.
//

import UIKit

class NoticeDetailViewController: UIViewController {

    // MARK: - Properties
    var imageURL: String = ""
    var titleString: String = ""
    var dateString: String = ""
    var fullTextString: String = ""
    var descriptionString: String = ""
    var bgColorString: String = ""
    
    
    
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardBackground: UIView!
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var cardDate: UILabel!
    @IBOutlet weak var cardDescription: UILabel!
    @IBOutlet weak var fullText: UILabel!
    @IBOutlet weak var textBackground: UIView!
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttribute()
        setContents()

        
    }
    
    
    
    // MARK: - Actions
    
    @IBAction func didDismissButtonTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    
    // MARK: - Helpers
    func setContents() {
        // 이미지 가져오기
        let url = URL(string: imageURL)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.cardImage.image = UIImage(data: data!)
            }
        }
        
        cardBackground.backgroundColor = UIColor(hexString: bgColorString)
        
         view.backgroundColor = UIColor(hexString: bgColorString)
        cardTitle.text = titleString
        cardDate.text = dateString
        cardDescription.text = descriptionString
        fullText.text = fullTextString
    }
    

    func setAttribute() {
        textBackground.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    


}
