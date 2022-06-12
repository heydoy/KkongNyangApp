//
//  CardCollectionViewCell.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardImageBackground: UIView!
    
    @IBOutlet weak var cardTitle: UILabel!
    
    @IBOutlet weak var cardDescription: UILabel!
    @IBOutlet weak var cardDate: UILabel!
    @IBOutlet weak var textBackground: UIView!
    
    
    @IBOutlet weak var isNewlyIssuedImage: UIImageView!
    
    // MARK: - Actions
    
    func configure(_ notice: Notice){
        
        //cardImage.image = image
        print(notice.bgcolor)
        cardImageBackground.backgroundColor = UIColor(hexString: notice.bgcolor)
        cardTitle.text = notice.title
        cardDescription.text = notice.description
        cardDate.text = notice.date
        
        // 날짜 기준으로 판단하여 뉴 뱃지 보여주기
        if dateCompare(notice.startDate, compare: "2022.08.01") > 0 {
            // 나중에는 날짜 판별해서 넣기
            isNewlyIssuedImage.alpha = 1
        } else {
            isNewlyIssuedImage.alpha = 0
        }
        
        // 이미지 가져오기
        let url = URL(string: notice.image)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.cardImage.image = UIImage(data: data!)
            }
        }
        
        setAttribute()
    }
    
    
    // MARK: - Helpers
    
    func setAttribute() {
        cardImageBackground.layer.cornerRadius = 16
        
        
        // 텍스트는 아래만 라운드를 줄 것
        textBackground.roundCorners(cornerRadius: 16, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
    }
    
    // 날짜 비교
    func dateCompare(_ string: String, compare: String) -> Int {
        let format = DateFormatter()
        format.dateFormat = "yyyy.MM.dd"
        
        guard let date = format.date(from: string) else { return -1 }
        guard let standard = format.date(from: compare) else { return -1 }
        
        let interval = Int(date.timeIntervalSince(standard))
        
        return interval

    }
}
