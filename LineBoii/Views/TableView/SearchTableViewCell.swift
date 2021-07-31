//
//  SearchTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 30/7/2564 BE.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    private let searchImageView: UIImageView = {
        let image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 3, weight: .regular))
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        return imageView
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "ค้นหาร้านหรือเมนูอาหาร"
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        
        addSubview(searchImageView)
        addSubview(placeholderLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchImageView.frame = CGRect(x: 5, y: 10, width: contentView.width * 0.1, height: contentView.height - 20)
        placeholderLabel.frame = CGRect(x: searchImageView.right + 2, y: 3, width: contentView.width * 0.6, height: contentView.height - 6)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    

}
