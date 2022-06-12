//
//  TodoViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/29.
//

import UIKit

class TodoViewController: UIViewController {

    
    // MARK: - Properties
    let catTodoList: [CatTodo] = CatTodo.list
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Data, Presentation, Layout (뷰컨트롤러가 위임함)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Notification Center
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissAddTodoNotification(_:)),
            name: NSNotification.Name("DismissAddTodoView"),
            object: nil)
        
    }
    
    // MARK: - Actions
    @objc func didDismissAddTodoNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
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
}


// MARK: - Extensions

extension TodoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
            cell.contentView.backgroundColor = UIColor(named: "todoFinished")
        }
        cell.layer.cornerRadius = 12
        
        return cell
    }
    
}

extension TodoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset: CGFloat = 20
        let width: CGFloat = collectionView.bounds.width - (inset * 2)
        
        return CGSize(width: width, height: 72)
    }
}

