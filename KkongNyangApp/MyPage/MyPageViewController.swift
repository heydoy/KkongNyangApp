//
//  MyPageViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/05/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MyPageViewController: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?

    // Firebase DB 주소
    let db: DatabaseReference! = Database.database(url: "https://kkongnyangapp-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    
    var familyCode: String = ""
    var catList = [Cat]()
    var catName: String = ""
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCats()
        getCatName()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
             // [START_EXCLUDE]
            self.getFamilyCode(user!.uid)
             // [END_EXCLUDE]
           }
    }
    
    // MARK: - Action
    @IBAction func didMyProfileButtonTapped(_ sender: UIButton) {
        print("집사프로필")
    }
    
    @IBAction func didInviteButlerTapped(_ sender: UIButton) {
        // 집사초대
        
        let storyboard = UIStoryboard.signupandlogin
        let butlerInvitationVC = storyboard.instantiateViewController(withIdentifier: "ButlerInvitationViewController") as! ButlerInvitationViewController
        
        butlerInvitationVC.familyCode = self.familyCode
        butlerInvitationVC.catName = self.catName
        
        self.present(butlerInvitationVC, animated: true, completion: nil)
        
    }
    
    
    @IBAction func didCatProfileButtonTapped(_ sender: UIButton) {
        print("고양이프로필")
    }
    
 
    @IBAction func didAlertSettingButtonTapped(_ sender: UIButton) {
        //print("알림설정")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let alertSettingViewController = storyboard.instantiateViewController(withIdentifier: "AlertSettingVC") as! AlertSettingViewController
        self.navigationController?.pushViewController(alertSettingViewController, animated: true)
    }
    
    
    @IBAction func didAppInfoButtonTapped(_ sender: UIButton) {
        //print("앱정보")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let appInfoViewController = storyboard.instantiateViewController(withIdentifier: "AppInfoVC") as! AppInfoViewController
        self.navigationController?.pushViewController(appInfoViewController, animated: true)
    }
    
    // MARK: - Helpers
    func getFamilyCode(_ uid: String){
        // firebasse

        self.db.child("users/\(uid)/catFamilyCode").getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
//            self.familyCode = (snapshot?.value as? String)!
            self.familyCode = "GER33"
        }
        
    }
    

    func fetchCats() {
        let catsDB = self.db.child("catFamilies/GER33/cat/01")
        
        catsDB.observeSingleEvent(of: .value) { snapshot in
            
            let allCats = snapshot.children.allObjects as! [DataSnapshot]
            
            for catSnap in allCats {
                let aCat = Cat(withSnapshot: catSnap)
                self.catList.append(aCat)
                print(self.catList)
            }
        }
    }
    
    func getCatName() {
        guard catList.count != 0 else { return }
        self.catName = catList[0].name
    }
}


