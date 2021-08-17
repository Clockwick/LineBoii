//
//  RestaurantHeaderCollectionViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 16/8/2564 BE.
//

import UIKit

protocol RestaurantHeaderCollectionViewCellDelegate: AnyObject {
    func restaurantHeaderCollectionViewCellDidTapButton(_ id: String, status: ButtonState)
}

class RestaurantHeaderCollectionViewCell: UICollectionViewCell {
    
    private var id: String = ""
    
    private var currentState: ButtonState = .none
    
    static let identifier = "RestaurantHeaderCollectionViewCell"
    
    lazy var buttonSize: CGSize? = .zero
    
    weak var delegate: RestaurantHeaderCollectionViewCellDelegate?
    
    lazy var activeButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.darkGreen, for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return btn
    }()
    
    lazy var nonActiveButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.secondaryLabel, for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(activeButton)
        contentView.addSubview(nonActiveButton)
        
        activeButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        nonActiveButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        delegate?.restaurantHeaderCollectionViewCellDidTapButton(self.id, status: self.currentState)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch self.currentState {
        case .active:
            showActiveButton()
        case .none:
            showNonActiveButton()
        }
    }
    
    func showActiveButton() {
        guard let buttonSize = buttonSize else {
            return
        }
        nonActiveButton.frame = .zero
        activeButton.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height - 7)
        let borderLine = UIView(frame: CGRect(x: 10, y: contentView.height - 7, width: buttonSize.width - 10, height: 2))
        borderLine.backgroundColor = .darkGreen
        activeButton.addSubview(borderLine)
    }
    
    func showNonActiveButton() {
        guard let buttonSize = buttonSize else {
            return
        }
        activeButton.frame = .zero
        nonActiveButton.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height - 7)
        let borderLine = UIView(frame: CGRect(x: 10, y: contentView.height - 7, width: buttonSize.width - 10, height: 2))
        borderLine.backgroundColor = .white
        activeButton.addSubview(borderLine)
    }
    
    func configure(with viewModel: RestaurantCategoryViewModel) {
        self.currentState = viewModel.status
        self.id = viewModel.id
        let title = viewModel.header
        
        let font: UIFont = .systemFont(ofSize: 20)
        let buttonTextSize = title.size(withAttributes: [.font: font as Any])
        self.buttonSize = buttonTextSize
        
        activeButton.setTitle(title, for: .normal)
        nonActiveButton.setTitle(title, for: .normal)
        
        
        setNeedsLayout()
        
        
    }
    
     
    
}
