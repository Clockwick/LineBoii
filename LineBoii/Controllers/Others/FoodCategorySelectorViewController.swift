//
//  FoodCategorySelectorViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 9/8/2564 BE.
//

import UIKit

class FoodCategorySelectorViewController: UIViewController {
    
    private var foodCategories = [FoodCategoryEnum:String]()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: self.view.width, height: 70)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ReusableViewCell")
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ViewCell")
        cv.register(FoodCategoryHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FoodCategoryHeaderCollectionReusableView.identifier)
        cv.register(FoodCategoryCollectionViewCell.self, forCellWithReuseIdentifier: FoodCategoryCollectionViewCell.identifier)
        cv.register(FoodCategorySearchViewCell.self, forCellWithReuseIdentifier: FoodCategorySearchViewCell.identifier)
        cv.backgroundColor = .systemBackground
        cv.isScrollEnabled = false
        return cv
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = .systemBackground
        configureModel()
        // Prototype delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Add subview
        view.addSubview(collectionView)

    }
    
    private func configureModel() {
        for category in FoodCategoryEnum.allCases {
            foodCategories[category] = category.title
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    
}

extension FoodCategorySelectorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return foodCategories.count
        }
        if section == 1 {
            // Search Button
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoryCollectionViewCell.identifier, for: indexPath) as! FoodCategoryCollectionViewCell
            let foodCategory = Array(foodCategories.keys)[indexPath.row]
            let foodCategoryText = Array(foodCategories.values)[indexPath.row]
            let buttonTextSize = foodCategoryText.size(withAttributes: [.font: UIFont(name: "supermarket", size: 16) as Any])
            let size = CGSize(width: 20 + buttonTextSize.width, height: buttonTextSize.height + 20)
            cell.configure(with: foodCategoryText, size: size, foodCategory: foodCategory, status: .none)
            return cell
        }
        if indexPath.section == 1 {
            // Show search button
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategorySearchViewCell.identifier, for: indexPath)
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FoodCategoryHeaderCollectionReusableView.identifier, for: indexPath) as! FoodCategoryHeaderCollectionReusableView
                return headerCell
            default:
                assert(false, "Unexpected Element Kind")
            }
        }
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ReusableViewCell", for: indexPath)
            return headerCell
        default:
            assert(false, "Unexpected Element Kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let foodCategoryText = Array(foodCategories.values)[indexPath.row]
            let buttonTextSize = foodCategoryText.size(withAttributes: [.font: UIFont(name: "supermarket", size: 16) as Any])
            let size = CGSize(width: 20 + buttonTextSize.width, height: buttonTextSize.height + 20)
            return size
        }
        if indexPath.section == 1 {
            return CGSize(width: collectionView.width - 30, height: 60)
        }
        return .zero
    }
    
}

extension FoodCategorySelectorViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        FoodCategorySelectorPresentationController(presentedViewController: presented, presenting: presenting)
    }
}



