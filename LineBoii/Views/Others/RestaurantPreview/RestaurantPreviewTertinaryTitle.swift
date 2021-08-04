//
//  RestaurantPreviewTertinaryTitle.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 3/8/2564 BE.
//

import UIKit

class RestaurantPreviewTertinaryTitle: UIView {
    
    
    private var price: String = "0"
    private var distance: String = "-"
    private var time: String = "0"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .thin)
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    private let carIcon: UIImageView = {
        let image = UIImage(systemName: "car")
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(carIcon)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        carIcon.frame = CGRect(x: 0, y: height / 3, width: 25, height: 25)
        titleLabel.frame = CGRect(x: carIcon.right + 2, y: carIcon.height / 2, width: width - carIcon.width, height: height * 0.7)
    }

    func configure(with price: String, distance: String, time: String) {
        titleLabel.text = "\(price)฿ | \(distance) km (\(time) min)"
    }
}
