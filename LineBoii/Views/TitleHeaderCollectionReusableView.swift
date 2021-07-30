//
//  TitleHeaderCollectionReusableView.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 28/7/2564 BE.
//

import UIKit


class TitleHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleHeaderCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: -40, y: 0, width: width, height: height)
    }
    
    func configure(with title: String) {
        label.text = title
    }
}
