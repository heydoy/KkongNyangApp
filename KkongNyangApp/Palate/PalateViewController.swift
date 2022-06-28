//
//  PalateViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/29.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class PalateViewController: UIViewController {

    // MARK: - Propertiess
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var handle: AuthStateDidChangeListenerHandle?
    var uid = ""
    var familyCode = ""
    // Firebase DB 주소
    let db: DatabaseReference! = Database.database(url: "https://kkongnyangapp-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    
    // var palateList: [CatPalate] = CatPalate.list
    var palateList = [Palate]()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPalates()
        
        // 콜렉션 뷰
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Refresh Control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        // Notification Center
        // 기호추가 화면이 사라질 때 콜렉션 뷰를 새로고침
        // Notification Center
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissAddPalateNotification(_:)),
            name: NSNotification.Name("DismissAddPalateView"),
            object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            self.getFamilyCode(user!.uid)
            self.collectionView.reloadData()
            
        })
    }
    
    // MARK: - Actions
    @objc func didDismissAddPalateNotification(_ notification: Notification) {
            DispatchQueue.main.async {
                self.palateList = [Palate]()
                self.fetchPalates()
                self.collectionView.reloadData()
        }
        
    }
    
    @objc func doSomething(refreshControl: UIRefreshControl) {
        DispatchQueue.main.async {
            self.palateList = [Palate]()
            self.fetchPalates()
            self.collectionView.reloadData()
        }
        refreshControl.endRefreshing()
        
    }
    
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {

        } else {

        }
    }
    
    @IBAction func didAddPalateButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addPalateViewController = storyboard.instantiateViewController(withIdentifier: "AddPalateVC") as! AddPalateViewController
        addPalateViewController.modalPresentationStyle = .fullScreen
        
        self.present(addPalateViewController, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func getFamilyCode(_ uid: String) {
        self.db.child("users/\(uid)/catFamilyCode").getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self.familyCode = (snapshot?.value as? String)!
        }
    }
    
    func fetchPalates() {
        let DB = self.db.child("palates/GER33")
        DB.observeSingleEvent(of: .value) { snapshot in
            let all = snapshot.children.allObjects as! [DataSnapshot]
            
            for palate in all {
                let a = Palate(withSnapshot: palate)
                self.palateList.append(a)
                print("기호기록 \(self.palateList) 안에 \(a.history) 데이터")
            }
        }
    }
    
}

// MARK: - Extensions

extension PalateViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(palateList.count)
        return palateList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PalateCollectionViewCell", for: indexPath) as? PalateCollectionViewCell else {
            return UICollectionViewCell()
        }
        let palate = palateList[indexPath.item]
        cell.configure(palate)
        
        return cell
    }
    
}

extension PalateViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset: CGFloat = 20
        let width: CGFloat = collectionView.bounds.width - (inset * 2)
        
        return CGSize(width: width, height: 92)
    }
}
