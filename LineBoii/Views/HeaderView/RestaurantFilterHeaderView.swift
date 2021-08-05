//
//  RestaurantFilterHeaderView.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 3/8/2564 BE.
//

import UIKit



class RestaurantFilterHeaderView: UIView{
    
    private var buttons = [String]()
    private let filterControlButton: FilterButton = FilterButton()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
    
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(80),
                                               heightDimension: .absolute(50)
            )
        )
//        item.contentInsets = NSDirectionalEdgeInsets(top: 7.5, leading: 7.5, bottom: 7.5, trailing: 7.5)
        
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)),
            subitem: item,
            count: 4)

        
        // Section
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        addSubview(filterControlButton)
        
        configureCollectionView()
        
        configureModel()
        
        backgroundColor = .secondarySystemBackground
        layer.zPosition = 9999
        
        
    }
    
    private func configureCollectionView() {
        // Delegate and Datasource
        collectionView.delegate = self
        collectionView.dataSource = self
//        // Register
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "cell")
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
    
    private func configureModel() {
        let dummy = ["เปิดอยู่", "บัตรเครดิต", "โปรโมชั่น", "รับที่ร้าน", "ราคา", "ประเภทอาหาร"]
        
        buttons = dummy
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        for subview in subviews {
//            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
//                return true
//            }
//        }
//        return false
//    }
    
    

}


extension RestaurantFilterHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCell
        let buttonLabel = buttons[indexPath.item]
        cell.configure(with: buttonLabel, parentButton: filterControlButton)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 40)
        
    }
    
}

class MyCell: UICollectionViewCell {

    var button = FilterElementButton()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(button)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 0, y: 0, width: width, height: 35)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String, parentButton: FilterButton) {
        button.configure(with: title, parentButton: parentButton)
    }
}
