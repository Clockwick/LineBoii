//
//  HeaderLocationTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 30/7/2564 BE.
//

import UIKit

class HeaderLocationTableViewCell: UITableViewCell {

    static let identifier = "HeaderLocationTableViewCell"
    
    private let locationImageView: UIImageView = {
        let image = UIImage(systemName: "mappin.and.ellipse", withConfiguration: UIImage.SymbolConfiguration(pointSize: 3, weight: .regular))
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let orderAtLabel: UILabel = {
        let label = UILabel()
        label.text = "จัดส่งที่:"
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        addSubview(locationImageView)
        addSubview(orderAtLabel)
        addSubview(locationLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        locationImageView.frame = CGRect(x: 10, y: 3, width: contentView.width * 0.1, height: contentView.height - 6)
        orderAtLabel.frame = CGRect(x: locationImageView.right + 1, y: 3, width: 45, height: contentView.height - 6)
        locationLabel.frame = CGRect(x: orderAtLabel.right + 1, y: 3, width: contentView.width - locationImageView.width - orderAtLabel.width, height: contentView.height - 6)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        locationLabel.text = ""
    }
    
    func configure(with locationName: String) {
        locationLabel.text = locationName
    }

}
