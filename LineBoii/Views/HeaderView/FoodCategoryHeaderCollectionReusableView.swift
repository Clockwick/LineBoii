//
//  FoodCategoryHeaderCollectionReusableView.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 10/8/2564 BE.
//

import UIKit

class FoodCategoryHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "FoodCategoryHeaderCollectionReusableView"
    private let label: UILabel = {
        let label = UILabel()
        let message = "ประเภทอาหาร"
        let attributedText =  NSMutableAttributedString().bold(message)
        label.attributedText = attributedText
        label.font = UIFont(name: "supermarket", size: 20)
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        label.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }

        
}
