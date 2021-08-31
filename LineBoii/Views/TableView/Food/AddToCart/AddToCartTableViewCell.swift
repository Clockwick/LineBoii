//
//  AddToCartTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 31/8/2564 BE.
//

import UIKit

class AddToCartTableViewCell: UITableViewCell {
    static let identifier = "AddToCartTableViewCell"
    
    
    @IBOutlet var decreaseButton: UIButton!
    @IBOutlet var increaseButton: UIButton!
    @IBOutlet var numberLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        decreaseButton.addTarget(self, action: #selector(didTapDecreaseButton), for: .touchUpInside)
        increaseButton.addTarget(self, action: #selector(didTapIncreaseButton), for: .touchUpInside)
        
    }
    
    @objc private func didTapDecreaseButton() {
        guard var number = Int(numberLabel.text!), number > 1 else {
            return
        }
        increaseButton.tintColor = .label
        if number <= 2 {
            decreaseButton.tintColor = .tertiaryLabel
        }
        
        number -= 1
        numberLabel.text = String(number)

    }
    
    @objc private func didTapIncreaseButton() {
        guard var number = Int(numberLabel.text!) else {
            return
        }
        if number >= 1 {
            decreaseButton.tintColor = .label
        }
        if number >= 100 {
            increaseButton.tintColor = .systemRed
            return
        }
        number += 1
        numberLabel.text = String(number)
        
    }

    
}
