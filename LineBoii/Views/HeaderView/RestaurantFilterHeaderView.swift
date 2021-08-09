//
//  RestaurantFilterHeaderView.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 3/8/2564 BE.
//

import UIKit



class RestaurantFilterHeaderView: UIView{
    
    private let filterOpenButton = FilterOpenButton()
    private let filterAllowCreditCardButton = FilterAllowCreditCardButton()
    private let filterPromotionButton = FilterPromotionButton()
    private let filterPickableButton = FilterPickableButton()
    private let filterPriceLevelButton = FilterPriceLevelButton()
    
    private let filterControlButton: FilterButton = FilterButton()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        addSubview(filterControlButton)
        configureCollectionView()
        
        
        backgroundColor = .secondarySystemBackground
        layer.zPosition = 9999
        
    }
    
    func passVcToHeaderView(vc: OrderFoodViewController) {
        filterControlButton.passVcToHeaderView(vc: vc)
        filterPriceLevelButton.passVcToHeaderView(vc: vc)
    }
    
    private func configureCollectionView() {
        // Delegate and Datasource
        collectionView.delegate = self
        collectionView.dataSource = self
        // Register
        collectionView.register(RestaurantFilterCollectionViewCell.self, forCellWithReuseIdentifier: RestaurantFilterCollectionViewCell.identifier)
        collectionView.backgroundColor = .secondarySystemBackground
        
        // Add to view
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        filterControlButton.frame = CGRect(x: 0, y: 5, width: 100, height: 35)
        collectionView.frame = CGRect(x: filterControlButton.right + 12, y: 3, width: width - 100, height: height)
    }
    
}


extension RestaurantFilterHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantFilterCollectionViewCell.identifier, for: indexPath) as! RestaurantFilterCollectionViewCell
        
        switch indexPath.row {
        case 0:
            cell.configure(with: filterOpenButton)
        case 1:
            cell.configure(with: filterAllowCreditCardButton)
        case 2:
            cell.configure(with: filterPromotionButton)
        case 3:
            cell.configure(with: filterPickableButton)
        case 4:
            cell.configure(with: filterPriceLevelButton)
        case 5:
//            cell.configure(with: buttonLabel, type: .foodType)
            break
        default:
            print("Case default")
            break
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 40)
    }
    
}


    
class RestaurantFilterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RestaurantFilterCollectionViewCell"
    
    var filterButton: UIView?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        filterButton?.frame = CGRect(x: 0, y: 0, width: width, height: 35)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.filterButton = nil
        
    }
    
    func configure(with filterButton: UIView) {
        self.filterButton = filterButton
        guard let button = self.filterButton else {
            return
        }
        contentView.addSubview(button)
    }
    
}
