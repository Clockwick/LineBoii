//
//  FilterButton.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 3/8/2564 BE.
//

import UIKit

enum ButtonState {
    case active
    case none
}

class FilterButton: UIView {
    
    weak var orderFoodControllerVC: OrderFoodViewController?
    
    var currentState: ButtonState = .none
    
    let activeButton: ActiveFilterButton = ActiveFilterButton()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("ตัวกรอง", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 0.25
        button.titleLabel?.font = UIFont(name: "supermarket", size: 16)
        let image = UIImage(systemName: "slider.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular))
        let imageView = UIImageView(image: image)
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        button.setImage(imageView.image, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
        addSubview(activeButton)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        gesture.numberOfTapsRequired = 1
        activeButton.isUserInteractionEnabled = true
        activeButton.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapButton() {
        let vc = RestaurantFilterViewController()
        if let orderFoodControllerVC = orderFoodControllerVC {
            let navVC = UINavigationController(rootViewController: vc)
            orderFoodControllerVC.present(navVC, animated: true, completion: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func passVcToHeaderView(vc: OrderFoodViewController) {
        orderFoodControllerVC = vc
    }
    
    func checkForStatus() {
        if activeButton.currentFilterNumber > 0 {
            currentState = .active
        }
        else {
            currentState = .none
        }
        setNeedsLayout()
     }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch currentState {
        case .active:
            activeButton.frame = CGRect(x: 3, y: 3, width: width, height: height)
            button.frame = .zero
            
        case .none:
            button.frame = CGRect(x: 3, y: 3, width: width, height: height)
            activeButton.frame = .zero
        }

        
    }

}
