//
//  OfficialAndInformationTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 13/8/2564 BE.
//

import UIKit

class OfficialAndInformationTableViewCell: UITableViewCell {
    
    static let identifier = "OfficialAndInformationTableViewCell"
    
    private var restaurantNavVC: UINavigationController?
    
    private var restaurantReviewViewModel: RestaurantReviewViewModel?
    
    private let fireImageView: UIImageView = {
        let image = UIImage(systemName: "flame.fill")
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemOrange
        return imageView
    }()
    
    private let officialLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        label.text = "Official Restaurant"
        label.textColor = .systemOrange
        return label
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("ดูข้อมูลร้าน", for: .normal)
        button.setTitleColor(.darkGreen, for: .normal)
        let image = UIImage(systemName: "chevron.right")
        let resultImage = image?.maskWithColor(color: .darkGreen)
        button.setImage(resultImage, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        // Set indicator
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(fireImageView)
        contentView.addSubview(officialLabel)
        contentView.addSubview(infoButton)
        
        infoButton.addTarget(self, action: #selector(didTapInfoButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fireImageView.frame = CGRect(x: 0, y: 0, width: contentView.height / 2, height: contentView.height / 2)
        officialLabel.frame = CGRect(x: fireImageView.right, y: 0, width: contentView.width / 2, height: contentView.height)
        
        infoButton.frame = CGRect(x: contentView.width - contentView.width / 3, y: 0, width: contentView.width / 3, height: contentView.height)
        
        fireImageView.center.y = contentView.center.y
        
    }
    
    @objc private func didTapInfoButton() {
        guard let restaurantNavVC = self.restaurantNavVC, let restaurantReviewViewModel = self.restaurantReviewViewModel else {
            return
        }
        let vc = RestaurantLocationViewController()
        vc.title = "รายละเอียดร้านอาหาร"
        vc.initialize(with: restaurantReviewViewModel)
        restaurantNavVC.pushViewController(vc, animated: true)
    }
    
    func configure(with restaurantNavVC: UINavigationController, viewModel: RestaurantReviewViewModel) {
        self.restaurantNavVC = restaurantNavVC
        self.restaurantReviewViewModel = viewModel
    }

}
