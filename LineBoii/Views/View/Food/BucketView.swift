//
//  BucketView.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 1/9/2564 BE.
//

import UIKit

class BucketView: UIView {
    
    private let addToBucketLabel: UILabel = {
        let label = UILabel()
        label.text = "ใส่ในตะกร้า"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let sumPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0฿"
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGreen
        layer.masksToBounds = true
        layer.cornerRadius = 10
        
        addSubview(addToBucketLabel)
        addSubview(sumPriceLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addToBucketLabel.frame = CGRect(x: 20, y: 10, width: frame.width / 3, height: frame.height - 20)
        sumPriceLabel.frame = CGRect(x: frame.width - 60, y: 10, width: 50, height: frame.height - 20)
        
    }
    
    
    
    func configure(with price: Int) {
        self.sumPriceLabel.text = "\(String(price))฿"
    }


}
