//
//  TodoViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/29.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class TodoViewController: UIViewController {

  
    // MARK: - Properties
    var handle: AuthStateDidChangeListenerHandle?
    var uid = ""
    // Firebase DB 주소
    let db: DatabaseReference! = Database.database(url: "https://kkongnyangapp-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    
    var catTodoList = [Todo]()
    
    var familyCode = ""
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Firebase
        // 데이터 가져오기
        
        fetchTodos()
        
        // Data, Presentation, Layout (뷰컨트롤러가 위임함)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        

        // Refresh Control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)
        //refreshControl.attributedTitle = NSAttributedString(string: "새로고침")
        collectionView.refreshControl = refreshControl
        
        
        // Notification Center
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissAddTodoNotification(_:)),
            name: NSNotification.Name("DismissAddTodoView"),
            object: nil)
        
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
    
    // MARK: - Actions
    @objc func didDismissAddTodoNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.catTodoList = [Todo]()
            self.fetchTodos()
        }        
        collectionView.reloadData()
    }
    
    @objc func doSomething(refreshControl: UIRefreshControl) {
        DispatchQueue.main.async {
            self.catTodoList = [Todo]()
            self.fetchTodos()
        }
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }

    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            
        } else if sender.selectedSegmentIndex == 1 {
           
        } else {
          
        }
    }
    
    
    @IBAction func didAddTodoButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let addTodoViewController = storyboard.instantiateViewController(withIdentifier: "AddTodoVC") as! AddTodoViewController
        
        addTodoViewController.modalPresentationStyle = .fullScreen
        self.present(addTodoViewController, animated: true, completion: nil)
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
        
    }
    
    // Database fetch
    func fetchTodos() {
        let todosDB = self.db.child("catFamilies/GER33/todo")
        
        todosDB.observeSingleEvent(of: .value) { snapshot in
            
            let allTodos = snapshot.children.allObjects as! [DataSnapshot]
            
            for todoSnap in allTodos {
                let aTodo = Todo(withSnapshot: todoSnap)
                self.catTodoList.append(aTodo)
                print(self.catTodoList)
            }
            self.collectionView.reloadData()
        }
    }
}


// MARK: - Extensions

extension TodoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(catTodoList.count)
        return catTodoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoListCollectionViewCell", for: indexPath) as? TodoListCollectionViewCell else {
            return UICollectionViewCell()
            }
        
        // 셀데이터 가져오기
        let todo = catTodoList[indexPath.item]
        cell.configure(todo)
        // 셀꾸미기
        if todo.isFinished == true {
            cell.contentView.backgroundColor = UIColor.todoFinished
        } else {
            cell.contentView.backgroundColor = UIColor.todoDefault
        }
        cell.layer.cornerRadius = 12
        
        // 셀 버튼
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(didCheckButtonTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc
    func didCheckButtonTapped(sender: UIButton) {
        
        let cell = catTodoList[sender.tag]
        cell.isFinished = !cell.isFinished
        
        // firebase에 업로드
        
        collectionView.reloadData()

    }
    
}


extension TodoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset: CGFloat = 20
        let width: CGFloat = collectionView.bounds.width - (inset * 2)
        
        return CGSize(width: width, height: 72)
    }
}

