//
//  MenuChoiceTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 29/8/2564 BE.
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
    
    @IBOutlet var choiceButton: UIButton!
    @IBOutlet var circle: UIImageView!
    @IBOutlet var circleFill: UIImageView!
    @IBOutlet var menuNameLabel: UILabel!
    @IBOutlet var bahtLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        circleFill.isHidden = true
        circle.isHidden = true
        choiceButton.setBackgroundImage(nil, for: .normal)
        
        choiceButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        switch currentButtonState {
        case true:
            circleFill.isHidden = true
            circle.isHidden = true
            choiceButton.setBackgroundImage(nil, for: .normal)
        case false:
            circleFill.isHidden = false
            circle.isHidden = false
            choiceButton.setBackgroundImage(circleFill.image, for: .normal)
        }
        self.currentButtonState = !self.currentButtonState
        delegate?.menuChoiceTableViewCellDidTap(at: self.indexPath, status: self.currentButtonState)
    }
    
    func initialize(with indexPath: IndexPath, currentIndexPath: IndexPath) {
        
        if indexPath != currentIndexPath {
            self.currentButtonState = false
            circleFill.isHidden = true
            circle.isHidden = true
            choiceButton.setBackgroundImage(nil, for: .normal)
        }
        else {
            self.currentButtonState = true
            circleFill.isHidden = false
            circle.isHidden = false
            choiceButton.setBackgroundImage(circleFill.image, for: .normal)
        }
        
        self.indexPath = indexPath
    }
    
    func configure(viewModel: Menu) {
        guard let menuNameLabel = self.menuNameLabel,
              let bahtLabel = self.bahtLabel else {
            return
        }
        menuNameLabel.text = viewModel.name
        bahtLabel.text = "\(viewModel.price)฿"
        
        self.menuNameLabel = menuNameLabel
        self.bahtLabel = bahtLabel
    }
    
}
