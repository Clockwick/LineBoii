//
//  FoodCategoryTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 10/8/2564 BE.
//

import UIKit

struct FoodCategorySetup {
    var foodcategory: FoodCategoryEnum
    var title: String
    var currentStatus: ButtonState
}

class FoodCategoryTableViewCell: UITableViewCell{
    
    static let identifier = "FoodCategoryTableViewCell"
    
    private var foodCategories = [FoodCategorySetup]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ViewCell")
        cv.register(FoodCategoryCollectionViewCell.self, forCellWithReuseIdentifier: FoodCategoryCollectionViewCell.identifier)
        cv.backgroundColor = .systemBackground
        cv.isScrollEnabled = false
        return cv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureModel()
        
        // Prototype delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Add subview
        contentView.addSubview(collectionView)
        
    }
    
    private func configureModel() {
        
        for category in FoodCategoryEnum.allCases {
            var foodCategorySetup = FoodCategorySetup(foodcategory: .thai, title: "", currentStatus: .none)
            foodCategorySetup.title = category.title
            foodCategorySetup.foodcategory = category
            foodCategories.append(foodCategorySetup)
        }
//        for foodcategory in foodCategoryArray {
//            switch foodcategory {
//            case .streetFood:
//                foodCategorySetup.currentStatus = .active
//            case .milkTea:
//                foodCategorySetup.currentStatus = .active
//            case .japanese:
//                foodCategorySetup.currentStatus = .active
//            case .east:
//                foodCategorySetup.currentStatus = .active
//            case .thai:
//                foodCategorySetup.currentStatus = .active
//            case .sea:
//                foodCategorySetup.currentStatus = .active
//            case .breakfast:
//                foodCategorySetup.currentStatus = .active
//            case .noodle:
//                foodCategorySetup.currentStatus = .active
//            case .dessert:
//                foodCategorySetup.currentStatus = .active
//            case .coffee:
//                foodCategorySetup.currentStatus = .active
//            case .bakery:
//                foodCategorySetup.currentStatus = .active
//            case .alacarte:
//                foodCategorySetup.currentStatus = .active
//            case .chinese:
//                foodCategorySetup.currentStatus = .active
//            case .oneDish:
//                foodCategorySetup.currentStatus = .active
//            case .boiledRice:
//                foodCategorySetup.currentStatus = .active
//            case .fastFood:
//                foodCategorySetup.currentStatus = .active
//            case .vietnamese:
//                foodCategorySetup.currentStatus = .active
//            case .sushi:
//                foodCategorySetup.currentStatus = .active
//            case .cleanfood:
//                foodCategorySetup.currentStatus = .active
//            case .dimsum:
//                foodCategorySetup.currentStatus = .active
//            }
//        }
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        collectionView.frame = contentView.bounds
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    
}

extension FoodCategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoryCollectionViewCell.identifier, for: indexPath) as! FoodCategoryCollectionViewCell
        
        let foodCategory = foodCategories[indexPath.row].foodcategory
        let foodCategoryText = foodCategories[indexPath.row].title
        let currentStatus = RestaurantFilterManager.shared.getStatus(from: foodCategory)
        let buttonTextSize = foodCategoryText.size(withAttributes: [.font: UIFont(name: "supermarket", size: 16) as Any])
        let size = CGSize(width: 20 + buttonTextSize.width, height: buttonTextSize.height + 20)
        // Fetch data from manager
        cell.configure(with: foodCategoryText, size: size, foodCategory: foodCategory, status: currentStatus)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let foodCategoryText = foodCategories[indexPath.row].title
        let buttonTextSize = foodCategoryText.size(withAttributes: [.font: UIFont(name: "supermarket", size: 16) as Any])
        let size = CGSize(width: 20 + buttonTextSize.width, height: buttonTextSize.height + 20)
        return size
    }
}
