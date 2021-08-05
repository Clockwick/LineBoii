//
//  FilterElementButton.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 4/8/2564 BE.
//

import UIKit

class FilterElementButton: UIView {
    
    private var currentState: ButtonState = .none
    
    private var parentButton: FilterButton = FilterButton()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
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
    }
    
    @objc private func didTapButton() {
        switch currentState {
        case .active:
            activeButton.frame = CGRect(x: 3, y: 3, width: width, height: height)
            activeButton.center = center
            button.frame = .zero
            currentState = .none
            self.parentButton.activeButton.decrementCurrentFilterNumber()
            
        case .none:
            button.frame = CGRect(x: 3, y: 3, width: width, height: height)
            button.center = center
            activeButton.frame = .zero
            currentState = .active
            self.parentButton.activeButton.incrementCurrentFilterNumber()
            
            
        }
        self.parentButton.checkForStatus()
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
    
    func configure(with title: String, parentButton: FilterButton) {
        button.setTitle(title, for: .normal)
        activeButton.setTitle(title, for: .normal)
        self.parentButton = parentButton
    }

}


