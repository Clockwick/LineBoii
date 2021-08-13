//
//  RestaurantImageTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 13/8/2564 BE.
//

import UIKit

class RestaurantImageTableViewCell: UITableViewCell {

    static let identifier = "RestaurantImageTableViewCell"
    
    var badges = [UIButton]()
    
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
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        
        imageView.backgroundColor = color.randomElement()
        imageView.tintColor = .systemBackground
        
        return imageView
    }()
    
    private let deliveryChargeBadge: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.isUserInteractionEnabled = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 2.0
        return button
    }()
    
    private let creditBadge: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.isUserInteractionEnabled = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.25
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 12)
        
        button.setTitleColor(.label, for: .normal)
        button.setTitle("บัตรเครดิต", for: .normal)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 2.0
        return button
    }()
    
    private let promotionBadge: UIButton = {
        let button = UIButton()
        button.isHidden = true
        
        button.isUserInteractionEnabled = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = .darkGreen
        button.setTitle("โปรโมชั่น", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 2.0
        return button
    }()
    
    private let luckyPointBadge: UIButton = {
        let button = UIButton()
        button.isHidden = true
        return button
    }()
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(restaurantImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        restaurantImageView.frame = CGRect(x: 0, y: 10, width: contentView.width, height: contentView.height)
        
        for (index, badge) in badges.enumerated() {
            let offset = CGFloat(10)
            let buttonSize = CGSize(width: 70, height: 25)
            badge.frame = CGRect(x: offset + (buttonSize.width * CGFloat(index)) + (offset * CGFloat(index)), y: 15, width: buttonSize.width, height: buttonSize.height)
        }
        
        
    }
    
    func configure(with viewModel: RestaurantImageViewModel) {
        // Set Image
        
        // Set Badge
        if let supportType = viewModel.supportTypes {
            for type in supportType {
                switch type {
                case .credit:
                    creditBadge.isHidden = false
                    badges.append(creditBadge)
                case .deliveryCharge(price: let price):
                    deliveryChargeBadge.isHidden = false
                    guard let price = price else {return}
                    if price == 0 {
                        deliveryChargeBadge.setTitle(type.charge, for: .normal)
                        deliveryChargeBadge.setTitleColor(.white, for: .normal)
                        deliveryChargeBadge.backgroundColor = .red
                    }
                    else if price > 0 , price <= 10 {
                        deliveryChargeBadge.setTitle(type.charge, for: .normal)
                        deliveryChargeBadge.setTitleColor(.white, for: .normal)
                        deliveryChargeBadge.backgroundColor = .systemRed
                    }
                    else if price > 10 , price <= 20 {
                        deliveryChargeBadge.setTitle(type.charge, for: .normal)
                        deliveryChargeBadge.setTitleColor(.white, for: .normal)
                        deliveryChargeBadge.backgroundColor = .systemOrange
                    }
                    else {
                        deliveryChargeBadge.setTitle(type.charge, for: .normal)
                        deliveryChargeBadge.setTitleColor(.label, for: .normal)
                        deliveryChargeBadge.backgroundColor = .white
                        deliveryChargeBadge.layer.borderWidth = 0.25
                        deliveryChargeBadge.layer.borderColor = UIColor.lightGray.cgColor
                    }
                    badges.append(deliveryChargeBadge)
                   
                case .promotion:
                    promotionBadge.isHidden = false
                    badges.append(promotionBadge)
                
                }
            }
            badges.forEach { (badge) in
                contentView.addSubview(badge)
            }

        }
        
    }

}
