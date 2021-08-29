//
//  MenuCheckboxTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 28/8/2564 BE.
//

import UIKit

protocol MenuCheckboxTableViewCellDelegate: AnyObject {
    func menuCheckboxTableViewCellDidTap(at indexPath: IndexPath, status: Bool)
}

class MenuCheckboxTableViewCell: UITableViewCell {
    static let identifier = "MenuCheckboxTableViewCell"
    
    weak var delegate: MenuCheckboxTableViewCellDelegate?
    
    private var currentButtonState: Bool = false
    private var indexPath: IndexPath = IndexPath.init(row: -1, section: -1)
    @IBOutlet var square: UIImageView!
    @IBOutlet var checkbox: UIImageView!
    @IBOutlet var menuNameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var checkboxButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        checkboxButton.setBackgroundImage(square.image?.maskWithColor(color: .secondaryLabel), for: .normal)
        
        checkboxButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        switch currentButtonState {
        case true:
            checkboxButton.setBackgroundImage(square.image?.maskWithColor(color: .secondaryLabel), for: .normal)
        case false:
            checkboxButton.setBackgroundImage(checkbox.image?.maskWithColor(color: .darkGreen), for: .normal)
        }
        self.currentButtonState = !self.currentButtonState
        delegate?.menuCheckboxTableViewCellDidTap(at: self.indexPath, status: self.currentButtonState)
    }
    
    func initialize(with indexPath: IndexPath) {
        self.indexPath = indexPath
    }

    func configure(viewModel: Menu) {
        guard let menuNameLabel = self.menuNameLabel,
              let priceLabel = self.priceLabel else {
            return
        }
        menuNameLabel.text = viewModel.name
        priceLabel.text = "\(viewModel.price)฿"
        
        self.menuNameLabel = menuNameLabel
        self.priceLabel = priceLabel
    }
    
}
