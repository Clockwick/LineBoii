//
//  NibFoodTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 19/8/2564 BE.
//

import UIKit

class NibFoodTableViewCell: UITableViewCell {
    
    static let identifier = "NibFoodTableViewCell"

    @IBOutlet var foodImageView: UIImageView!
    @IBOutlet var foodTitleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: Food) {
        foodTitleLabel.text = viewModel.title
        priceLabel.text = "\(String(viewModel.price))฿"
        
        guard viewModel.subtitle.count != 0 else {
            return
        }
        guard let subtitleLabel = self.subtitleLabel else {
            return
        }
        subtitleLabel.text = viewModel.subtitle
        self.subtitleLabel = subtitleLabel
    }
    
}
