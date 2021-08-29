//
//  MenuChoiceTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 28/8/2564 BE.
//

import UIKit

protocol MenuChoiceTableViewCellDelegate: AnyObject {
    func menuChoiceTableViewCellDidTap(at indexPath: IndexPath, status: Bool)
}

class MenuChoiceTableViewCell: UITableViewCell {
    static let identifier = "MenuChoiceTableViewCell"
    
    weak var delegate: MenuChoiceTableViewCellDelegate?
    
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
        delegate?.menuChoiceTableViewCellDidTap(at: self.indexPath, status: self.currentButtonState)
    }
    
    func initialize(with indexPath: IndexPath) {
        self.indexPath = indexPath
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
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
