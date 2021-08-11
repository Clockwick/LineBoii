//
//  FoodCategoryGreenWhiteButton.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 9/8/2564 BE.
//

import UIKit

class FoodCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FoodCategoryCollectionViewCell"
    
    var currentState: ButtonState = .none
    
    private var buttonSize: CGSize?
    
    private var foodCategory: FoodCategoryEnum?
    
    private var observer: NSObjectProtocol?
    private var clearObserver: NSObjectProtocol?

    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 0.25
        button.titleLabel?.font = UIFont(name: "supermarket", size: 16)
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
    private let activeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .darkGreen
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.darkGreen.cgColor
        button.layer.borderWidth = 0.25
        button.titleLabel?.font = UIFont(name: "supermarket", size: 16)
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activeButton)
        addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        activeButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        observer = NotificationCenter.default.addObserver(
            forName: .foodCategoryNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let strongSelf = self else {return}
                
                switch strongSelf.currentState {
                // Update UI
                case .active:
                    strongSelf.showActiveButton()
                case .none:
                    strongSelf.showNonActiveButton()
                }
                strongSelf.setNeedsLayout()
        })
        
        clearObserver = NotificationCenter.default.addObserver(
            forName: .clearFilterAllNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let strongSelf = self else {return}
                strongSelf.showNonActiveButton()
                strongSelf.setNeedsLayout()
        })
        
    }
    
    deinit {
        guard let observer = observer else {
            return
        }
        guard let clearObserver = clearObserver else {
            return
        }
        NotificationCenter.default.removeObserver(observer)
        NotificationCenter.default.removeObserver(clearObserver)
    }
    
    func showActiveButton() {
        guard let buttonSize = buttonSize else {
            return
        }
        activeButton.frame = CGRect(x: 0, y: 0, width: buttonSize.width, height: buttonSize.height)
        button.frame = .zero
        currentState = .active
        
    }
    func showNonActiveButton() {
        guard let buttonSize = buttonSize else {
            return
        }
        button.frame = CGRect(x: 0, y: 0, width: buttonSize.width, height: buttonSize.height)
        activeButton.frame = .zero
        currentState = .none
    }

    @objc private func didTapButton() {
        switch currentState {
        
        case .active:
            guard let foodCategory = foodCategory else {
                return
            }
            RestaurantFilterManager.shared.popFoodCategory(foodCategory: foodCategory)
            showNonActiveButton()
        case .none:
            guard let foodCategory = foodCategory else {
                return
            }
            RestaurantFilterManager.shared.pushFoodCategory(foodCategory: foodCategory)
            showActiveButton()
        }
        setNeedsLayout()
        RestaurantFilterManager.shared.calculateCurrentSelectedItems()
        NotificationCenter.default.post(name: .foodCategoryNotification, object: nil)
    }
    
    func configure(with title: String, size: CGSize, foodCategory: FoodCategoryEnum, status: ButtonState) {
//        print("\(title) : width = \(size.width) , height = \(size.height)")
        self.buttonSize = size
        self.foodCategory = foodCategory
        self.currentState = status
        button.setTitle(title, for: .normal)
        activeButton.setTitle(title, for: .normal)
        activeButton.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        button.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        switch currentState {
        // Update UI
        case .active:
            showActiveButton()
        case .none:
            showNonActiveButton()
        }
        setNeedsLayout()
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch currentState {
        case .active:
            showActiveButton()
        case .none:
            showNonActiveButton()
        }
        
    }

}
