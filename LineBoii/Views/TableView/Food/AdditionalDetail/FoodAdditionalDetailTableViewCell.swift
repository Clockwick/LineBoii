//
//  FoodAdditionalDetailTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 30/8/2564 BE.
//

import UIKit

class FoodAdditionalDetailTableViewCell: UITableViewCell {
    
    static let identifier = "FoodAdditionalDetailTableViewCell"

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
