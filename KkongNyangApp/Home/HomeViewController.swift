//
//  HomeViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/29.
//

import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController {
    // Firebase DB 가져오기
    let db: DatabaseReference! = Database.database(url: "https://kkongnyangapp-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    

    // MARK: - Properties
    let homecardlist: [HomeCard] = HomeCard.list
    let finishedlist: [FinishedTodo] = FinishedTodo.list
    
    @IBOutlet weak var newImage: UIImageView!
    
    
    @IBOutlet weak var goToEventHistoryButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView! // 카드 : 이벤트
    
    @IBOutlet weak var collectionViewB: UICollectionView! // 육묘기록
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 파이어베이스
        db.child("firstData").observeSingleEvent(of: .value) { snapshot in
            print("-->\(snapshot)")
            let value = snapshot.value as? String ?? ""
            print(value)
        }
        
        // 메서드 실행
        setAttribute()
        
        // 컬렉션뷰 등록(위임)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionViewB.dataSource = self
        collectionViewB.delegate = self
    }
    
    // MARK: - Actions
    
    
    // MARK: - Helpers
    func setAttribute(){
        goToEventHistoryButton.layer.cornerRadius = 8
    }
    
}


// MARK: - Extensions
extension HomeViewController: UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            // 첫번째일경우
            return homecardlist.count
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
            let homecard = homecardlist[indexPath.item]
            cell.configure(homecard)
            
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


