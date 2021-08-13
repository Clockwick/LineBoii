//
//  BrandTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 12/8/2564 BE.
//

import UIKit

class BrandRestaurantTableViewCell: UITableViewCell {

    static let identifier = "BrandTableViewCell"
    
    private let brandImageView: UIImageView = {
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
    
    private let closeView: UIView = {
        let view = UIView()
        view.isHidden = true
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height))
        label.center.y = view.center.y
        label.text = "ปิด"
        label.textColor = .white
        view.backgroundColor = .gray
        view.addSubview(label)
        
        return view
    }()
    
    private let restaurantPreviewTitle = RestaurantPreviewTitle()
    private let restaurantPreviewTertinaryTitle = RestaurantPreviewTertinaryTitle()
    private let restaurantPreviewBadges = RestaurantPreviewBadge()
        
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(brandImageView)
        contentView.addSubview(restaurantPreviewTitle)
        contentView.addSubview(restaurantPreviewTertinaryTitle)
        contentView.addSubview(restaurantPreviewBadges)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        brandImageView.frame = CGRect(x: 0, y: 0, width: contentView.width * 0.3, height: contentView.height)
        restaurantPreviewTitle.frame = CGRect(x: brandImageView.right + 10 , y: 20, width: contentView.width * 0.6, height: 20)
        restaurantPreviewTertinaryTitle.frame = CGRect(x: brandImageView.right + 10, y: restaurantPreviewTitle.bottom, width: contentView.width * 0.6, height: 30)
        restaurantPreviewBadges.frame = CGRect(x: brandImageView.right + 10, y: restaurantPreviewTertinaryTitle.bottom + 10, width: contentView.width * 0.6, height: 30)
        
    }
    
    func configure(with viewModel: BrandRestaurantViewModel) {
        restaurantPreviewTitle.configure(with: viewModel.title)
        restaurantPreviewTertinaryTitle.configure(with: String(viewModel.deliveryPrice), distance: String(viewModel.distance), time: String(viewModel.time))
        if let supportType = viewModel.supportType {
            restaurantPreviewBadges.configure(with: supportType)
        }
        if !viewModel.isOpen {
            closeView.isHidden = false
            closeView.frame = brandImageView.frame
        }
        
    }
    
}
