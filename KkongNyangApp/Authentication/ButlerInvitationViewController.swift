//
//  ButlerInvitationViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/17.
//

import UIKit
import MessageUI

class ButlerInvitationViewController: UIViewController {

    // MARK: - Properties
    var catName: String = ""
    var familyCode: String = ""
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    // MARK: - Actions
    
    @IBAction func didSMSInvitationButtonTapped(_ sender: UIButton) {
        
        guard MFMessageComposeViewController.canSendText() else {
            let unavailableAlert = UIAlertController(title: "SMS 전송서비스 사용불가", message: "SMS 서비스를 사용할 수 없습니다. 나중에 다시 시도해주세요", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            unavailableAlert.addAction(cancelAction)
            self.present(unavailableAlert, animated: true, completion: nil)
            print("SMS services are not available")
            return
        }
        
        let composeViewController = MFMessageComposeViewController()
        
        composeViewController.body =
        """
        우리 꽁냥에서 함께 🐈 \(self.catName) 키워요!
        🔗 앱 링크 : https://kkongnyang.app/
        📌 초대코드 : \(self.familyCode)
        
        회원가입 화면에서 위 초대코드를 입력하세요

        """
        
        present(composeViewController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func didShareButtonTapped(_ sender: UIButton) {
        
        let objectsToShare: [String] = [
            "\(self.catName) 육아를 함께 해주세요.",
            "🔗 앱 링크 : https://kkongnyang.app/",
            "📌 초대코드 : \(self.familyCode)",
            "회원가입 화면에서 위 초대코드를 입력하세요"
        ]
       
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        // 공유하기 기능 중 제외할 기능이 있을 때 사용
//        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    // MARK: - Helpers
    


}

// MARK: - Extensions
extension ButlerInvitationViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .sent :
            //print("sent")
            
            dismiss(animated: true, completion: nil)
        case .cancelled :
            print("canceled")
            dismiss(animated: true, completion: nil)
        case .failed :
            print("failed")
            dismiss(animated: true, completion: nil)
        @unknown default:
            print("unknow error")
            dismiss(animated: true, completion: nil)


        }
    }
}
