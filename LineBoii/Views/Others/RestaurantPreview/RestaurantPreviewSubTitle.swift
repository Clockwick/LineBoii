//
//  RestaurantPreviewSubTitle.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 3/8/2564 BE.
//

import UIKit


class RestaurantPreviewSubTitle: UIView {
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .thin)
        label.numberOfLines = 1
        return label
    }()
    
    private let announcementIcon: UIImageView = {
        let image = UIImage(systemName: "bahtsign.circle")
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemRed
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(announcementIcon)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        announcementIcon.frame = CGRect(x: 0, y: 5, width: 20, height: 20)
        titleLabel.frame = CGRect(x: announcementIcon.right + 2, y: 0, width: width - announcementIcon.width, height: 30)
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
}
