//
//  _2x4CollectionViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 31/7/2564 BE.
//

import UIKit

class _2x4CollectionViewCell: UICollectionViewCell {
    static let identifier = "_2x4CollectionViewCell"
    
    private let imageView: UIImageView = {
        let image = UIImage(systemName: "photo")
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height / 2)
        label.frame = CGRect(x: 0, y: imageView.bottom, width: contentView.width, height: (contentView.height / 2) - 5)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = ""
        
    }
    
    func configure(with viewModel: PromotionCollectionViewCellViewModel) {
        label.text =  viewModel.title
    }
    
}
