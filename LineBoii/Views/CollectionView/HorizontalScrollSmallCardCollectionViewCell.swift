//
//  HorizontalScrollSmallCardCollectionViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 31/7/2564 BE.
//

import UIKit

class HorizontalScrollSmallCardCollectionViewCell: UICollectionViewCell {
    static let identifier = "HorizontalScrollSmallCardCollectionViewCell"
    
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
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondarySystemBackground
    
        layer.cornerRadius = 5
        
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height * 0.8)
        titleLabel.frame = CGRect(x: 0, y: imageView.bottom + 3, width: contentView.width, height:contentView.height * 0.2)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imageView.image = nil
    }
    
    func configure(with viewModel: PopularCategoryViewModel) {
        titleLabel.text = viewModel.title
//        imageView.sd_setImage(with: viewModel.imageURL), completed: nil)
    }
}
