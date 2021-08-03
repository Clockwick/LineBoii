//
//  RestautantPreviewTitle.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 3/8/2564 BE.
//

import UIKit

class RestaurantPreviewTitle: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let fireImageView: UIImageView = {
        let image = UIImage(systemName: "flame.fill")
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemOrange
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(fireImageView)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        fireImageView.frame = CGRect(x: 0, y: height / 8, width: 25, height: 25)
        titleLabel.frame = CGRect(x: fireImageView.right + 2, y: 0, width: width - fireImageView.width, height: height * 0.7)
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
    

}
