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
    var familyCode = ""
    var uid = ""
    var userName = ""
    // Firebase DB 주소
    let db: DatabaseReference! = Database.database(url: "https://kkongnyangapp-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    
    var catTodoList = [Todo]()

    
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
        
        self.db.child("users/\(uid)/name").getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self.userName = (snapshot?.value as? String)!
        }
        
    }
    
    // Database fetch
    func fetchTodos() {
        let todosDB = self.db.child("catFamilies/GER33/todo")
        
        todosDB.observeSingleEvent(of: .value) { snapshot in
            
            let allTodos = snapshot.children.allObjects as! [DataSnapshot]
            
            for todoSnap in allTodos {
                // todoSnap.key
                // print("MARK: Todo 키값----> \(todoSnap.key)")
                let aTodo = Todo(withSnapshot: todoSnap)
                self.catTodoList.append(aTodo)
                
            }
            self.catTodoList.sort(by: {$0 > $1})
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
//            cell.finishedStamp.alpha = 1
        } else {
            cell.contentView.backgroundColor = UIColor.todoDefault
//            cell.finishedStamp.alpha = 0
        }
        cell.layer.cornerRadius = 12
        
        // 셀 버튼
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(didActionButtonTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc
    func didActionButtonTapped(sender: UIButton) {
        
        let cell = catTodoList[sender.tag]
        // cell.isFinished = !cell.isFinished
        
        
        let actionSheet = UIAlertController(title: "할 일", message: "\(cell.title)의 액션을 고르세요", preferredStyle: .actionSheet)
        
        var finishText = ""
        if cell.isFinished == true {
            finishText = "완료 취소하기"
        } else {
            finishText = "완료하기"
        }
        
        let finish = UIAlertAction(title: finishText, style: .default) { _ in

            
            cell.isFinished = !cell.isFinished
            
            
            if cell.isFinished == true {
//                let now = Date()
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "\(self.userName)님이 a h시 m분 완료"
//                dateFormatter.locale = Locale(identifier: "ko_KR")
//                let convertedString = dateFormatter.string(from: now)
//
//                cell.finishTime = convertedString
                
                let alertParent = self.db.child("alert/\(self.familyCode)")
                
                let alertPost = [
                    "time" : Date().toString(),
                    "finishedFrom" : self.userName,
                    "todo" : cell.title,
                    "todoKey" : cell.key,
                    "isFinished" : true,
 
                ] as [String:Any]
                
                alertParent.childByAutoId().updateChildValues(alertPost)
                
                // 파이어베이스에 투두 isFinished 업데이트
                print(cell.key)
                let todoParent = self.db.child("catFamilies/\(self.familyCode)/todo/\(cell.key)")
                
                
                let todoPost = [
                            "isFinished": true,
                            "finishTime": Date().toString()
                ] as [String : Any]
                
                todoParent.updateChildValues(todoPost)
                
                
                self.showToast(message: "\(cell.title) \n완료하였습니다.")
                
            } else {
                // 완료취소인경우 완수타임 비우기
                cell.finishTime = ""
                
                // 파이어베이스에 투두 isFinished 업데이트
                let todoParent = self.db.child("catFamilies/\(self.familyCode)/todo/\(cell.key)")
                
                
                let todoPost = [
                            "isFinished": false,
                            "finishTime": ""
                ] as [String : Any]
                
                todoParent.updateChildValues(todoPost)
                
                self.showToast(message: "\(cell.title) \n완료 취소하였습니다.")
            }
            self.collectionView.reloadData()
            
        }
        
        let askFamily = UIAlertAction(title: "가족에게 요청하기", style: .default) { _ in
            // 가족에게 메시지 보내기
            
            let parent = self.db.child("alert/\(self.familyCode)")
            
            let post = [
                "time" : Date().toString(),
                "askedFrom" : self.userName,
                "todo" : cell.title,
                "todoKey" : cell.key,
                "isFinished" : false,
                "isAsked": true
            ] as [String:Any]
            
            parent.childByAutoId().updateChildValues(post)
            
            self.showToast(message: "가족에게 \(cell.title) \n요청하셨습니다.")
        }
        
        let editTodo = UIAlertAction(title: "수정하기", style: .default) { _ in
            // edit 창 보여주기
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let addTodoViewController = storyboard.instantiateViewController(withIdentifier: "AddTodoVC") as! AddTodoViewController
            
            addTodoViewController.familyCode = self.familyCode
            addTodoViewController.isEditing = true
            addTodoViewController.catID = cell.catId
            addTodoViewController.todo = cell.title
            print("수정할 타이틀 --> \(cell.title)")
            addTodoViewController.time = cell.time
            addTodoViewController.image = cell.image
            addTodoViewController.memo = cell.memo
            
            addTodoViewController.modalPresentationStyle = .fullScreen
            self.present(addTodoViewController, animated: true, completion: nil)
            
        } 
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheet.addAction(finish)
        actionSheet.addAction(askFamily)
        actionSheet.addAction(editTodo)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)

        // 리로드
        
        collectionView.reloadData()

    }
    
    // toast message
    func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 12.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height-200, width: 200, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.numberOfLines = 2
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.3, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}


extension TodoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset: CGFloat = 20
        let width: CGFloat = collectionView.bounds.width - (inset * 2)
        
        return CGSize(width: width, height: 72)
    }
}

