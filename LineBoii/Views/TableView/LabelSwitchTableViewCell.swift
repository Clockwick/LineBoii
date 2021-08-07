//
//  LabelSwitchTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 5/8/2564 BE.
//

import UIKit

class LabelSwitchTableViewCell: UITableViewCell {

    static let identifier = "LabelSwitchTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    private let sw: UISwitch = {
        let sw = UISwitch()
        return sw
    }()
    
    private var type: FilterType?
    
    private var observer: NSObjectProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        addSubview(sw)
        sw.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func switchStateDidChange(_ sender: UISwitch) {
        if sender.isOn {
            switch type {
            case .none:
                break;
            case .isOpen:
                fatalError("WTF")
            case .isAllowCreditCard:
                print("allow")
                RestaurantFilterManager.shared.isAllowCreditCard = true
                NotificationCenter.default.post(name: .isAllowCreditCardNotification, object: nil)
            case .isPromotion:
                print("promotion")
                RestaurantFilterManager.shared.isPromotion = true
                NotificationCenter.default.post(name: .isPromotionNotification, object: nil)
            case .isPickable:
                print("ispickable")
                RestaurantFilterManager.shared.isPickable = true
                NotificationCenter.default.post(name: .isPickableNotification, object: nil)
            case .priceLevel:
                // Present interface
                print("PriceLevel")
            case .foodType:
                // Present interface
                print("FoodType")
            
            
            }
            
        }
        else {
            switch type {
            case .none:
                break;
            case .isOpen:
                fatalError("WTF")
            case .isAllowCreditCard:
                RestaurantFilterManager.shared.isAllowCreditCard = false
                NotificationCenter.default.post(name: .isAllowCreditCardNotification, object: nil)
            case .isPromotion:
                RestaurantFilterManager.shared.isPromotion = false
                NotificationCenter.default.post(name: .isPromotionNotification, object: nil)
            case .isPickable:
                RestaurantFilterManager.shared.isPickable = false
                NotificationCenter.default.post(name: .isPickableNotification, object: nil)
            case .priceLevel:
                // Present interface
                print("PriceLevel")
            case .foodType:
                // Present interface
                print("FoodType")
            
            
            }
        }
        RestaurantFilterManager.shared.calculateCurrentSelectedItems()
        NotificationCenter.default.post(name: .filterChangeNotification, object: nil)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 20, y: 5, width: width / 2, height: height - 10)
        sw.frame = CGRect(x: width - 70, y: 10, width: 30, height: height - 10)
        
        
    }
    
    func configure(with viewModel: LabelSwitchViewModel, type: FilterType) {
        label.text = viewModel.title
        self.type = type
    }
    
    func setSwitchStatus(status: Bool) {
        sw.setOn(status, animated: false)
    }
    
    func turnOff() {
        sw.isOn = false
        switchStateDidChange(_:sw)
    }

}


class BoldLabelSwitchTableViewCell: UITableViewCell {

    static let identifier = "BoldLabelSwitchTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let sw: UISwitch = {
        let sw = UISwitch()
        return sw
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        addSubview(sw)
        sw.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)

            
    }
    
    @objc private func switchStateDidChange(_ sender: UISwitch) {
        if sender.isOn {
            RestaurantFilterManager.shared.isOpen = true
        }
        else {
            RestaurantFilterManager.shared.isOpen = false
        }
        
        NotificationCenter.default.post(name: .isOpenNotification, object: nil)
        RestaurantFilterManager.shared.calculateCurrentSelectedItems()
        NotificationCenter.default.post(name: .filterChangeNotification, object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 20, y: 5, width: width / 2, height: height - 10)
        sw.frame = CGRect(x: width - 70, y: 10, width: 30, height: height - 10)
    }
    
    func configure(with viewModel: LabelSwitchViewModel) {
        label.text = viewModel.title
    }
    
    func turnOff() {
        sw.isOn = false
        switchStateDidChange(_:sw)
    }
    
    func setSwitchStatus(status: Bool) {
        sw.setOn(status, animated: false)
    }

}
