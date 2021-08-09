//
//  FilterPriceLevelButton.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 7/8/2564 BE.
//

import UIKit



class FilterPriceLevelButton: UIView {
    
    weak var orderFoodControllerVC: OrderFoodViewController?
    
    private var currentState: ButtonState = .none
    
    private var observer: NSObjectProtocol?
    
    private var clearObserver: NSObjectProtocol?
    
    private let button: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.down")!
        
        let imageView = UIImageView(image: image)
        imageView.image = image.maskWithColor(color: .black)
        imageView.contentMode = .scaleAspectFill
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        button.setImage(imageView.image, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.setTitle("ราคา", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 0.25
        button.titleLabel?.font = UIFont(name: "supermarket", size: 16)
        
        button.semanticContentAttribute = .forceRightToLeft
        
        return button
    }()
    
    private let activeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.down")!
        let imageView = UIImageView(image: image)
        imageView.image = image.maskWithColor(color: .white)
        imageView.contentMode = .scaleAspectFill
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        button.setImage(imageView.image, for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.setTitle("ราคา", for: .normal)
        button.backgroundColor = .darkGreen
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.darkGreen.cgColor
        button.layer.borderWidth = 0.25
        button.titleLabel?.font = UIFont(name: "supermarket", size: 16)
        
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        addSubview(button)
        addSubview(activeButton)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        activeButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        observer = NotificationCenter.default.addObserver(
            forName: .priceLevelNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let strongSelf = self else {return}
                let isActive = RestaurantFilterManager.shared.priceLevelArray.count != 0
                if isActive {
                    strongSelf.currentState = .none
                }
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
    
    func passVcToHeaderView(vc: OrderFoodViewController) {
        orderFoodControllerVC = vc
    }

    @objc private func didTapButton() {
        let vc = PriceSelectorViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = vc.self
        orderFoodControllerVC?.present(vc, animated: true, completion: nil)
//        switch currentState {
//        // Update UI
//        case .active:
//            showNonActiveButton()
//        case .none:
//            showActiveButton()
//        }
//
        
//        RestaurantFilterManager.shared.calculateCurrentSelectedItems()
//        NotificationCenter.default.post(name: .filterChangeNotification, object: nil)
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


