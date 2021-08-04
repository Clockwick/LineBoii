//
//  ActiveFilterButton.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 3/8/2564 BE.
//

import UIKit

class ActiveFilterButton: UIView {

    private var currentFilterNumber: Int = 0
    
    private let filterLabel: UILabel = {
        let label = UILabel()
        label.text = "ตัวกรอง"
        label.textColor = .systemBackground
        label.font = UIFont(name: "supermarket", size: 16)
        return label
    }()
    
    private let currentFilterNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGreen
        label.numberOfLines = 1
        label.text = "9+"
        label.font = UIFont(name: "supermarket", size: 12)
        label.textAlignment = .center
        return label
    }()
    
    private let circleView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15
        layer.masksToBounds = true
        backgroundColor = UIColor.darkGreen
        addSubview(self.filterLabel)
        addSubview(self.circleView)
        addSubview(self.currentFilterNumberLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let circleSize = width / 4
        
        filterLabel.frame = CGRect(x: 0, y: 0, width: width / 2, height: height)
        filterLabel.center = CGPoint(x: 40, y: center.y)
        
        circleView.frame = CGRect(x: filterLabel.right, y: filterLabel.top + 2, width: circleSize, height: circleSize)
    
        circleView.layer.cornerRadius = circleSize / 2
        currentFilterNumberLabel.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        currentFilterNumberLabel.center = circleView.center

        
    }
    
    
    

}
