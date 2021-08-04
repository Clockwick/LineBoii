//
//  RestaurantPreviewTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 3/8/2564 BE.
//

import UIKit

class RestaurantPreviewTableViewCell: UITableViewCell {
    
    static let identifier = "RestaurantPreviewTableViewCell"
    
    private let restaurantPreviewTitle = RestaurantPreviewTitle()
    
    private let restaurantPreviewSubTitle = RestaurantPreviewSubTitle()
    
    private let restaurantPreviewTertinaryTitle = RestaurantPreviewTertinaryTitle()
    
    private let restaurantImageView: UIImageView = {
        
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

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.borderWidth = 0.25
        layer.masksToBounds = true
        layer.cornerRadius = 2
        
        addSubview(restaurantImageView)
        addSubview(restaurantPreviewTitle)
        addSubview(restaurantPreviewSubTitle)
        addSubview(restaurantPreviewTertinaryTitle)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        restaurantImageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: (contentView.height * 0.55))
        restaurantPreviewTitle.frame = CGRect(x: 10, y: restaurantImageView.bottom + 10, width: contentView.width, height: 60)
        restaurantPreviewSubTitle.frame = CGRect(x: 10, y: restaurantPreviewTitle.bottom, width: contentView.width, height: 20)
        restaurantPreviewTertinaryTitle.frame = CGRect(x: 10, y: restaurantPreviewSubTitle.bottom, width: contentView.width, height: 20)
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: RestaurantListPreviewViewModel) {
        restaurantPreviewTitle.configure(with: viewModel.name)
        restaurantPreviewSubTitle.configure(with: viewModel.subtitle ?? "")
        restaurantPreviewTertinaryTitle.configure(with: String(viewModel.deliveryPrice), distance: String(viewModel.distance), time: viewModel.time)
    }

}
