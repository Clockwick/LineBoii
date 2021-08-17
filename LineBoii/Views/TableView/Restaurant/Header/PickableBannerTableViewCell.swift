//
//  PickableBannerTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 13/8/2564 BE.
//

import UIKit



class PickableBannerTableViewCell: UITableViewCell {

    static let identifier = "PickableBannerTableViewCell"

    private let pickableLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "สามารถรับที่ร้านได้แล้ว"
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 0.25
        contentView.layer.borderColor = UIColor.gray.cgColor
        
        contentView.addSubview(pickableLabel)
        contentView.addSubview(distanceLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pickableLabel.frame = CGRect(x: 10, y: 0, width: 175, height: contentView.height)
        distanceLabel.frame = CGRect(x: pickableLabel.right, y: 0, width: contentView.width / 2, height: contentView.height)
    }
    
    func configure(with distance: Float) {
        distanceLabel.text = " • \(String(distance))กม"
        
    }

}
