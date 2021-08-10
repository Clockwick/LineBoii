//
//  FoodCategorySearchViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 10/8/2564 BE.
//

import UIKit

class FoodCategorySearchViewCell: UICollectionViewCell {
    static let identifier = "FoodCategorySearchViewCell"
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("ค้นหา", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGreen
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchButton)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        searchButton.frame = CGRect(x: 0, y: 0, width: contentView.width, height: 50)
    }
}
