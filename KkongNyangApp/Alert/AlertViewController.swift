//
//  AlertViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/05.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AlertViewController: UIViewController {

    // MARK: Properties
    var handle: AuthStateDidChangeListenerHandle?
    var uid = ""
    var userName = ""
    var familyCode = ""
    
    // Firebase DB 주소
    let db: DatabaseReference! = Database.database(url: "https://kkongnyangapp-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    
    var alertList = [Alert]()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 컬렉션 뷰 등록
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Refresh Control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)
        //refreshControl.attributedTitle = NSAttributedString(string: "새로고침")
        collectionView.refreshControl = refreshControl
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
             // [START_EXCLUDE]
            self.getFamilyCode(user!.uid)
             self.collectionView.reloadData()
             // [END_EXCLUDE]
           }
    }
    
    // MARK: Actions
    @objc func doSomething(refreshControl: UIRefreshControl) {
        DispatchQueue.main.async {
            self.alertList = [Alert]()
            self.fetchAlerts()
        }
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }
    
    // MARK: - Helpers
    func getFamilyCode(_ uid: String){
        // firebasse

        self.db.child("users/\(uid)/catFamilyCode").getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self.familyCode = (snapshot?.value as? String)!
        }
        
        self.db.child("users/\(uid)/name").getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self.userName = (snapshot?.value as? String)!
        }
        
    }
    // Database Fetch
    func fetchAlerts() {
        let alertDB = self.db.child("alert/GER33").queryOrderedByKey()
        
        alertDB.observeSingleEvent(of: .value) { snapshot in
            
            let all = snapshot.children.allObjects as! [DataSnapshot]
            
            for alertSnap in all {
                let aAlert = Alert(withSnapshot: alertSnap)
                self.alertList.append(aAlert)
                print(self.alertList)
            }
            self.alertList.sort(by: {$0 > $1})
            self.collectionView.reloadData()
        }
    }

}

// MARK: - Extensions

extension AlertViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alertList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlertCollectionViewCell", for: indexPath) as? AlertCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let alert = alertList[indexPath.row]
        cell.configure(alert)
        
        // 셀 버튼
        cell.finishButton.tag = indexPath.row
        cell.finishButton.addTarget(self, action: #selector(didFinishButtonTapped(sender:)), for: .touchUpInside)
        return cell
    }
    @objc func didFinishButtonTapped(sender: UIButton){
        let cell = alertList[sender.tag]
        
        let alarm = UIAlertController(title: "할 일 완료하기", message: "\(cell.todo)를 완료하셨나요?", preferredStyle: .alert)
        
        let finish = UIAlertAction(title: "완료하기", style: .default) { _ in
            cell.isFinished = true
            
            // 내 알림 업데이트
            let selfParent = self.db.child("alert/\(self.familyCode)/\(cell.key)")
            let selfPost = [
                "isFinished" : true,
                "finishedFrom" : self.userName
            ] as [String:Any]
            
            selfParent.updateChildValues(selfPost)

            
            // 파이어베이스에 투두 isFinished 업데이트
            let todoParent = self.db.child("catFamilies/\(self.familyCode)/todo/\(cell.todoKey)")
            
            
            let todoPost = [
                        "isFinished": true,
                        "finishTime": Date().toString()
            ] as [String : Any]
            
            todoParent.updateChildValues(todoPost)
            
            
            self.collectionView.reloadData()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alarm.addAction(finish)
        alarm.addAction(cancel)
        
        self.present(alarm, animated: true, completion: nil)
        
        collectionView.reloadData()
        
    }
    
    
}


extension AlertViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let inset: CGFloat = 0
//        let width: CGFloat = collectionView.bounds.width - (inset * 2)
        return CGSize(width: collectionView.bounds.width, height: 95)
        // 추후에 완료버튼 없이 dynamic height 만들기
    }
}
