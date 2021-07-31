//
//  HoritonzalScrollCollectionViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 30/7/2564 BE.
//

import UIKit
import SDWebImage

class HorizontalScrollCollectionViewCell: UICollectionViewCell {

    static let identifier = "HorizontalScrollCollectionViewCell"
    
    private var isRound = true
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imageView.image = nil
    }
    
    func configure(with viewModel: AdvertisementViewModel) {
//        imageView.sd_setImage(with: viewModel.imageURL), completed: nil)
    }
    
    
    
}

