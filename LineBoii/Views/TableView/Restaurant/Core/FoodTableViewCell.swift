//
//  FoodTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 17/8/2564 BE.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    static let identifier = "FoodTableViewCell"
    
    private let foodImageView: UIImageView = {
        let image = UIImage(systemName: "photo")
        let imageView = UIImageView(image: image)
        
        let color: [UIColor] = [
            .label,
            .systemGreen,
            .systemYellow,
            .systemRed
        ]
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.backgroundColor = color.randomElement()
        imageView.tintColor = .secondarySystemBackground
            
        return imageView
    }()
    
    private let foodPreviewTitle = FoodPreviewTitle()
    private let foodPreviewSubtitle = FoodPreviewSubtitle()
//    private let restaurantPreviewBadges = RestaurantPreviewBadge()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(foodImageView)
        contentView.addSubview(foodPreviewTitle)
        contentView.addSubview(foodPreviewSubtitle)
//        contentView.addSubview(restaurantPreviewBadges)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        foodImageView.frame = CGRect(x: 0, y: 0, width: contentView.width * 0.3, height: contentView.height)
        foodPreviewTitle.frame = CGRect(x: foodImageView.right + 10 , y: 20, width: contentView.width * 0.5, height: 20)
        foodPreviewSubtitle.frame = CGRect(x: foodImageView.right + 10, y: foodPreviewTitle.bottom, width: contentView.width * 0.6, height: 30)
//        restaurantPreviewBadges.frame = CGRect(x: foodImageView.right + 10, y: foodPreviewSubtitle.bottom + 10, width: contentView.width * 0.5, height: 30)
        
    }
    
    func configure(with viewModel: Food) {
        foodPreviewTitle.configure(with: viewModel.title)
        foodPreviewSubtitle.configure(with: viewModel.subtitle ?? "")
    }
    
    func getBoundsHeight() -> CGFloat {
        return self.foodPreviewSubtitle.bottom
    }

}
