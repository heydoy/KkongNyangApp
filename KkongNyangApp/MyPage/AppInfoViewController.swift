//
//  AppInfoViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/22.
//

import UIKit
import SafariServices
import AcknowList
import MessageUI


class AppInfoViewController: UIViewController {

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("\(self.getCurrentVersion())")


    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    // MARK: - Action
    
    @IBAction func didBackButtonTapped(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
        viewWillAppear(true)

    }
    
    // 이용약관
    @IBAction func didTermsOfServiceButtonTapped(_ sender: UIButton) {
        
        guard let url = URL(string: "https://kimdee.notion.site/5bf0498b615749e683e7678aea3fe720") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    // 오픈소스 라이선스
    @IBAction func didOpenSourceLicenseButtonTapped(_ sender: UIButton) {
        
        let acknowList = AcknowListViewController(fileNamed: "Pods-KkongNyangApp-acknowledgements")
        self.navigationController?.pushViewController(acknowList, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        
    }
    
    // 개인정보처리방침
    @IBAction func didPrivacyPolicyButtonTapped(_ sender: UIButton) {
        guard let url = URL(string: "https://kimdee.notion.site/26c37dff0def4e9197f2b6c3d82e7c00") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    @IBAction func didAppFeedbackButtonTapped(_ sender: UIButton) {
        
        // 이메일창이 나타나는 컨트롤러
        guard MFMailComposeViewController.canSendMail() else {
            // 사용자의 메일 계정이 설정되어 있지 않아 메일을 보낼 수 없다는 경고 메시지 추가
            print("메일 보내기 실패")
            let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "메일을 보내려면 'Mail' 앱이 필요합니다. App Store에서 해당 앱을 복원하거나 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
            let goAppStoreAction = UIAlertAction(title: "App Store로 이동하기", style: .default) { _ in
                // 앱스토어로 이동하기(Mail)
                if let url = URL(string: "https://apps.apple.com/kr/app/mail/id1108187098"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            let cancleAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            
            sendMailErrorAlert.addAction(goAppStoreAction)
            sendMailErrorAlert.addAction(cancleAction)
            self.present(sendMailErrorAlert, animated: true, completion: nil)
            return
        }
        
        
        let emailTitle = "[꽁냥]" // 메일 제목
                let messageBody =
                """
                📌 OS Version: \(UIDevice.current.systemVersion)
                📌 Device:   \(UIDevice().type)
                📌 App Version: \(self.getCurrentVersion())
                ----------------------------------------
                📌 내용:
                꽁냥 앱 문의, 버그 신고, 피드백 내용에 대해 입력해주세요.
                스크린샷을 함께 첨부해주시면 도움이 됩니다. 🙇‍♂️
                
                
                """
        // 3
              let toRecipents = ["kimdee.dev@gmail.com"]
              let mc: MFMailComposeViewController = MFMailComposeViewController()
              mc.mailComposeDelegate = self
              mc.setSubject(emailTitle)
              mc.setMessageBody(messageBody, isHTML: false)
              mc.setToRecipients(toRecipents)
              
              self.present(mc, animated: true, completion: nil)
          }
          
          // 4
          @objc(mailComposeController:didFinishWithResult:error:)
          func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult,error: Error?) {
                  controller.dismiss(animated: true)
          }
    
    // MARK: - Helpers
    // 현재 버전 가져오기
    func getCurrentVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }
    

    
}


// MARK: - Extensions
// 메일 연결
extension AppInfoViewController: MFMailComposeViewControllerDelegate {
}


