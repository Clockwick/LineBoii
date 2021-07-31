//
//  HorizontalScrollBrandCollectionViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 31/7/2564 BE.
//

import UIKit

class HorizontalScrollBrandCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HorizontalScrollBrandCollectionViewCell"
    
    lazy var imageViewSize = contentView.width 
    
    lazy var imageView: UIImageView = {
        let image = UIImage(systemName: "photo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = self.imageViewSize / 2
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondarySystemBackground
        
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 0, width: self.imageViewSize, height: self.imageViewSize)
        titleLabel.frame = CGRect(x: 0, y: imageView.bottom, width: self.imageViewSize, height: 40)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: BrandBadgeViewModel) {
        titleLabel.text = viewModel.title
    }
    
}
