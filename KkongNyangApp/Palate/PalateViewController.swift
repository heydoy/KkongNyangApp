//
//  PalateViewController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/04/29.
//

import UIKit

class PalateViewController: UIViewController {

    // MARK: - Propertiess
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let palateList: [CatPalate] = CatPalate.list
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 콜렉션 뷰
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    // MARK: - Actions
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
    
}

// MARK: - Extensions

extension PalateViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        
        return CGSize(width: width, height: 88)
    }
}
