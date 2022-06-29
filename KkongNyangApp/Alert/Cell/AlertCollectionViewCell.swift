//
//  AlertCollectionViewCell.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit

class AlertCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    
    func configure(_ alert: Alert) {
        timeLabel.text = timeCalcalculation(alert.time)
        
        
        if alert.isFinished == false {
            finishButton.isEnabled = true
            descriptionLabel.text = "\(alert.from) 님이 \(alert.todo)를 요청하셨습니다."
        } else {
            finishButton.isEnabled = false
            finishButton.setTitle("완료", for: .disabled)
            descriptionLabel.text = "\(alert.from) 님이 \(alert.todo)를 완료하셨습니다."
            
        }
    }
    
    func timeCalcalculation(_ time: String) -> String{
        // "YYYY-MM-dd hh:mm"
        let now = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        
        let compare = time.toDate()

        let useTime = Int(now.timeIntervalSince(compare!))
        
        var returnText = ""
        if useTime/60 < 1{
            returnText = "방금 전"
        } else if useTime/60 > 1 && useTime/60 < 60 {
            returnText = "\(useTime/60)분 전"
        } else if useTime/3600 >= 1 && useTime/3600 < 23 {
            returnText = "\(useTime/3600)시간 전"
        } else if useTime/3600 >= 24 && useTime/3600 < 48 {
            returnText = "하루 전"
        } else if useTime/3600 > 48 {
            let dayCount = useTime/(3600*24)
            returnText = "\(dayCount)일 전"
        }
        
        
        return returnText
    }
    
}
