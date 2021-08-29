//
//  FoodHeaderTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 27/8/2564 BE.
//

import UIKit



class FoodHeaderTableViewCell: UITableViewCell {
    
    static let identifier = "FoodHeaderTableViewCell"

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(title: String, subtitle: String) {
        guard let titleLabel = titleLabel,
              let subtitleLabel = subtitleLabel else {
            return
        }
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        self.titleLabel = titleLabel
        self.subtitleLabel = subtitleLabel
    }
    
}
