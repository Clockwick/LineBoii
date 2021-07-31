//
//  HorizontalRestaurantPromotionCardCollectionViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 31/7/2564 BE.
//

import UIKit

class HorizontalRestaurantPromotionCardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HorizontalRestaurantPromotionCardCollectionViewCell"
    
    lazy var realPriceText = ""
    
    lazy var discountText = ""
    
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
        
        label.textColor = .label
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12, weight: .thin)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var realPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .thin)
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.realPriceText)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        label.attributedText = attributeString
        label.isHidden = true
        return label
    }()
    
    lazy var discountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.text = self.discountText
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.isHidden = true
        return label
    }()
    
    private let badgeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemRed
        label.textColor  = .white
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()
    
    private let freeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.text = "ฟรี"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.isHidden = true
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
        addSubview(badgeLabel)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(realPriceLabel)
        addSubview(discountLabel)
        addSubview(freeLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height * 0.5)
        badgeLabel.frame = CGRect(x: 5, y: 5, width: contentView.width * 0.3, height: imageView.height * 0.2)
        titleLabel.frame = CGRect(x: 5, y: imageView.bottom + 3, width: contentView.width, height:contentView.height * 0.2)
        subtitleLabel.frame = CGRect(x: 5, y: titleLabel.bottom + 3, width: contentView.width, height:contentView.height * 0.05)
        realPriceLabel.frame = CGRect(x: 5, y: subtitleLabel.bottom + 14, width: 30, height:contentView.height * 0.1)
        discountLabel.frame = CGRect(x: realPriceLabel.right + 6, y: subtitleLabel.bottom + 12, width: 60, height:contentView.height * 0.1)
        freeLabel.frame = CGRect(x: 5, y: subtitleLabel.bottom + 14, width: 60, height:contentView.height * 0.1)
        
        imageView.layer.masksToBounds = true
        imageView.roundCorners(corners: [.topLeft, .topRight], radius: 5)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
    }
    
    func configure(with viewModel: PromotionCardViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.restaurantName
        
        if viewModel.isFree {
            discountLabel.isHidden = true
            realPriceLabel.isHidden = true
            freeLabel.isHidden = false
        }
        else {
            freeLabel.isHidden = true
            discountLabel.isHidden = false
            realPriceLabel.isHidden = false
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "฿" + viewModel.realPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            realPriceLabel.attributedText = attributeString
            discountLabel.text = "฿" + viewModel.discountPrice
        }
        badgeLabel.text = viewModel.badge.title
        
        
        
        //        imageView.sd_setImage(with: viewModel.imageURL), completed: nil)
    }
    
}
