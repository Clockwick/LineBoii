//
//  MenuChoiceTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 28/8/2564 BE.
//

import UIKit


@IBDesignable
class MenuChoiceTableViewCell: UITableViewCell {
    static let identifier = "MenuChoiceTableViewCell"
    
    @IBOutlet var checkbox: UIImageView!
    @IBOutlet var menuNameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkbox.backgroundColor = .white
        checkbox.tintColor = .darkGreen
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
