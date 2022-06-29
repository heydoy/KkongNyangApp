//
//  HomeViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/29.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController {
    // Firebase DB 주소
    let db: DatabaseReference! = Database.database(url: "https://kkongnyangapp-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    
    var handle: AuthStateDidChangeListenerHandle?
    var uid = ""
    var familyCode = ""

    // MARK: - Properties
    //let homecardlist: [HomeCard] = HomeCard.list
    var noticeArrayDataSource = [Notice]()
    let finishedlist: [FinishedTodo] = FinishedTodo.list
    
    @IBOutlet weak var newImage: UIImageView!
    
    
    @IBOutlet weak var goToEventHistoryButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView! // 카드 : 이벤트
    
    @IBOutlet weak var collectionViewB: UICollectionView! // 육묘기록
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 데이터 가져오기
        fetchNotices()

        // 메서드 실행
        setAttribute()
        
        // 컬렉션뷰 등록(위임)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionViewB.dataSource = self
        collectionViewB.delegate = self
        
        // Refresh Control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            //
            self.getFamilyCode(user!.uid)
            self.collectionView.reloadData()
            //
        })
    }
    
    
    
    // MARK: - Actions
    @objc func doSomething(refreshControl: UIRefreshControl) {
        DispatchQueue.main.async {
            self.noticeArrayDataSource = [Notice]()
            self.fetchNotices()
        }
        refreshControl.endRefreshing()
        collectionView.reloadData()
        
    }
    
    // MARK: - Helpers
    func setAttribute(){
        goToEventHistoryButton.layer.cornerRadius = 8
    }
    
    func getFamilyCode(_ uid: String) {
        self.db.child("users/\(uid)/catFamilyCode").getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            self.familyCode = (snapshot?.value as? String)!
        }
    }
    
    // MARK: - Database fetch
    func fetchNotices() {
        let noticesDB = self.db.child("notices")
        noticesDB.observeSingleEvent(of: .value) { snapshot in
            let allNotices = snapshot.children.allObjects as! [DataSnapshot]
            for noticeSnap in allNotices {
                let aNotice = Notice(withSnapshot: noticeSnap)
                self.noticeArrayDataSource.append(aNotice)
            }
            self.collectionView.reloadData()
        }
    }
    
}


// MARK: - Extensions
extension HomeViewController: UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            // 첫번째일경우
            return noticeArrayDataSource.count
        } else {
            // 두번째일경우
            return finishedlist.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            // 첫번째일경우
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else {
                return UICollectionViewCell()
            }
            // 셀에 데이터
            let notice = noticeArrayDataSource[indexPath.item]
            cell.configure(notice)
            
            // 셀 꾸미기
            cell.layer.cornerRadius = 16
            cell.layer.borderWidth = 0.0
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.layer.shadowRadius = 5.0
            cell.layer.shadowOpacity = 0.1
            cell.layer.masksToBounds = false
            
            return cell
            
        } else {
            // 두번째일 경우
            guard let cell = collectionViewB.dequeueReusableCell(withReuseIdentifier: "FinishedTodoCollectionViewCell", for: indexPath) as? FinishedTodoCollectionViewCell else {
                return UICollectionViewCell()
            }
                    
            // 셀에 데이터
            let finished = finishedlist[indexPath.item]
            cell.configure(finished)
            // 셀꾸미기
            cell.layer.cornerRadius = 16
            
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 셀 클릭시
        let notice = noticeArrayDataSource[indexPath.item]
        
        let storyboard = UIStoryboard.main
        
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "NoticeDetailViewController") as! NoticeDetailViewController
        
        detailViewController.modalPresentationStyle = .fullScreen
        
        detailViewController.imageURL = notice.image
        detailViewController.bgColorString = notice.bgcolor
        detailViewController.titleString = notice.title
        detailViewController.dateString = (notice.endDate == "" ) ? notice.startDate : "\(notice.startDate) ~ \(notice.endDate)"
        detailViewController.descriptionString = notice.description
        detailViewController.fullTextString = notice.body
        
        
        self.present(detailViewController, animated: true, completion: nil)
        
        
    }
    
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            // 첫번째일경우
            return CGSize(width: 200, height: 292)
        } else {
            // 두번째일경우
            return CGSize(width: 72, height: 72)
        }
        
    }
}


