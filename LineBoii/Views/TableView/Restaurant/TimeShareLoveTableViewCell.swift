//
//  TimeShareLoveTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 13/8/2564 BE.
//

import UIKit

class TimeShareLoveTableViewCell: UITableViewCell {

    static let identifier = "TimeShareLoveTableViewCell"
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.text = "เปิด จนถึง "
        return label
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        let shareImage = UIImage(systemName: "square.and.arrow.up")
        button.setImage(shareImage, for: .normal)
        return button
    }()
    
    private let loveButton: UIButton = {
        let button = UIButton()
        let shareImage = UIImage(systemName: "heart")
        button.setImage(shareImage, for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(timeLabel)
        contentView.addSubview(shareButton)
        contentView.addSubview(loveButton)
        
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        loveButton.addTarget(self, action: #selector(didTapLove), for: .touchUpInside)
    }
    
    @objc private func didTapShare() {
        print("Share")
        
    }
    
    @objc private func didTapLove() {
        let isActive = loveButton.imageView?.image == UIImage(systemName: "heart.fill") ? true : false
        if isActive {
            loveButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        else {
            loveButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        timeLabel.frame = CGRect(x: 5, y: 0, width: contentView.width / 2, height: contentView.height)
        loveButton.frame = CGRect(x: contentView.width - contentView.height, y: 0, width: contentView.height, height: contentView.height)
        shareButton.frame = CGRect(x: contentView.width - loveButton.width - contentView.height, y: 0, width: contentView.height, height: contentView.height)
    }
    
    
    
    func configure(with time: String) {
        timeLabel.text = "เปิด จนถึง \(time)"
    }


}
