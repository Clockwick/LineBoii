//
//  HorizontalScrollTitleCardCollectionViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 31/7/2564 BE.
//

import UIKit

class HorizontalScrollTitleCardCollectionViewCell: UICollectionViewCell {
    static let identifier = "HorizontalScrollTitleCardCollectionViewCell"

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
        label.font = .systemFont(ofSize: 14, weight: .semibold)
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
        
        
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height * 0.7)
        titleLabel.frame = CGRect(x: 6, y: imageView.bottom + 6, width: contentView.width, height:contentView.height * 0.15)
        
        imageView.layer.masksToBounds = true
        imageView.roundCorners(corners: [.topLeft, .topRight], radius: 5)
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    //        imageView.image = nil
    }

    func configure(with viewModel: PreviewRestaurantCardViewModel) {
        titleLabel.text = viewModel.title
        
    //        imageView.sd_setImage(with: viewModel.imageURL), completed: nil)
    }

}
