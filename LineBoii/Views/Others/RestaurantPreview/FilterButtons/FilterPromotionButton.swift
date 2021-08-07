//
//  FilterPromotionButton.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 7/8/2564 BE.
//


import UIKit


class FilterPromotionButton: UIView {
    
    private var currentState: ButtonState = .none
    
    private var observer: NSObjectProtocol?
    
    private var clearObserver: NSObjectProtocol?
    
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("โปรโมชั่น", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 0.25
        button.titleLabel?.font = UIFont(name: "supermarket", size: 16)
        return button
    }()
    
    private let activeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBackground, for: .normal)
        button.setTitle("โปรโมชั่น", for: .normal)
        button.backgroundColor = .darkGreen
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.darkGreen.cgColor
        button.layer.borderWidth = 0.25
        button.titleLabel?.font = UIFont(name: "supermarket", size: 16)
        return button
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
        addSubview(activeButton)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        activeButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        observer = NotificationCenter.default.addObserver(
            forName: .isPromotionNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let strongSelf = self else {return}
                switch strongSelf.currentState {
                // Update UI
                case .active:
                    strongSelf.showNonActiveButton()
                case .none:
                    strongSelf.showActiveButton()
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
        activeButton.frame = CGRect(x: 3, y: 3, width: width, height: height)
        activeButton.center = center
        button.frame = .zero
        currentState = .active
        
    }
    func showNonActiveButton() {
        button.frame = CGRect(x: 3, y: 3, width: width, height: height)
        button.center = center
        activeButton.frame = .zero
        currentState = .none
        
    }

    @objc private func didTapButton() {
        switch currentState {
        // Update UI
        case .active:
            showNonActiveButton()
        case .none:
            showActiveButton()
        }
        RestaurantFilterManager.shared.isPromotion = !RestaurantFilterManager.shared.isPromotion
        RestaurantFilterManager.shared.calculateCurrentSelectedItems()
        NotificationCenter.default.post(name: .filterChangeNotification, object: nil)
        setNeedsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch currentState {
        case .active:
            activeButton.frame = CGRect(x: 3, y: 3, width: width, height: height)
            activeButton.center = center
            button.frame = .zero
            
        case .none:
            button.frame = CGRect(x: 3, y: 3, width: width, height: height)
            button.center = center
            activeButton.frame = .zero
        }

    }
    
    

}



