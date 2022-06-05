//
//  TodoViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/29.
//

import UIKit

class TodoViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var addTodoButton: UIButton!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Data, Presentation, Layout (뷰컨트롤러가 위임함)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        
    }
    
    // MARK: - Actions
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            
        } else if sender.selectedSegmentIndex == 1 {
           
        } else {
          
        }
    }
    
    // MARK: - Helpers
}


// MARK: - Extensions

extension TodoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}

extension TodoViewController: UICollectionViewDelegate {
    
}

