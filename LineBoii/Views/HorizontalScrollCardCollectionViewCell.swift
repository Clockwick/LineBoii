//
//  HorizontalScrollCardCollectionViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 29/7/2564 BE.
//

import UIKit

class HorizontalScrollCardCollectionViewCell: UICollectionViewCell {
    static let identifier = "HorizontalScrollCardCollectionViewCell"
    
    private let imageView: UIImageView = {
        
        let image = UIImage(systemName: "photo")
        
        let imageView = UIImageView(image: image)
        
        let color: [UIColor] = [
            .label,
            .systemGreen,
            .systemYellow,
            .systemRed
        ]
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.backgroundColor = color.randomElement()
        imageView.tintColor = .secondarySystemBackground
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.clipsToBounds = true
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.clipsToBounds = true
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 2.0
        
        layer.cornerRadius = 5
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height * 0.6)
        titleLabel.frame = CGRect(x: 3, y: imageView.bottom + 1, width: contentView.width, height:contentView.height * 0.15)
        subtitleLabel.frame = CGRect(x: 3, y: titleLabel.bottom + 1, width: contentView.width, height:contentView.height * 0.15)
        
        imageView.layer.masksToBounds = true
        imageView.roundCorners(corners: [.topLeft, .topRight], radius: 5)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imageView.image = nil
    }
    
    func configure(with viewModel: RestaurantPreviewViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
//        imageView.sd_setImage(with: viewModel.imageURL), completed: nil)
    }
}
