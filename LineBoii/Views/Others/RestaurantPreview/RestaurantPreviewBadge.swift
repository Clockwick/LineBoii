//
//  RestaurantPreviewBadge.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 12/8/2564 BE.
//

import UIKit

class RestaurantPreviewBadge: UIView {

    private let deliveryPriceButton: UIButton = {
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
    
    private let creditButton: UIButton = {
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
    
    private let luckyPointButton: UIButton = {
        let button = UIButton()
        button.isHidden = false
        button.isUserInteractionEnabled = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Lucky Point x 2", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 2.0
        return button
    }()
    
    private let promotionButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.isUserInteractionEnabled = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = .darkGreen
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 2.0
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(deliveryPriceButton)
        addSubview(creditButton)
        addSubview(promotionButton)
        addSubview(luckyPointButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let offset = CGFloat(2)
    
        deliveryPriceButton.frame = CGRect(x: 0, y: 0, width: (width / 3) - (2 * offset) - 5, height: height)
        creditButton.frame = CGRect(x: deliveryPriceButton.right + offset, y: 0, width: (width / 3)  - (2 * offset) - 5, height: height)
        luckyPointButton.frame = CGRect(x: creditButton.right + offset, y: 0, width: (width / 3)  - (2 * offset) + 10, height: height)
        
    }

    func configure(with viewModel: [SupportType]) {
        
        for type in viewModel {
//            print("Type: \(type)")
            switch type {
            case .credit:
                creditButton.isHidden = false
                
            case .deliveryCharge(price: let price):
                deliveryPriceButton.isHidden = false
                guard let price = price else {return}
                if price == 0 {
                    deliveryPriceButton.setTitle(type.charge, for: .normal)
                    deliveryPriceButton.setTitleColor(.white, for: .normal)
                    deliveryPriceButton.backgroundColor = .red
                }
                else if price > 0 , price <= 10 {
                    deliveryPriceButton.setTitle(type.charge, for: .normal)
                    deliveryPriceButton.setTitleColor(.white, for: .normal)
                    deliveryPriceButton.backgroundColor = .systemRed
                }
                else if price > 10 , price <= 20 {
                    deliveryPriceButton.setTitle(type.charge, for: .normal)
                    deliveryPriceButton.setTitleColor(.white, for: .normal)
                    deliveryPriceButton.backgroundColor = .systemOrange
                }
                else {
                    deliveryPriceButton.setTitle(type.charge, for: .normal)
                    deliveryPriceButton.setTitleColor(.label, for: .normal)
                    deliveryPriceButton.backgroundColor = .white
                    deliveryPriceButton.layer.borderWidth = 0.25
                    deliveryPriceButton.layer.borderColor = UIColor.lightGray.cgColor
                }
               
            case .promotion:
                promotionButton.isHidden = false
            
            }
        }
        
    }

}
