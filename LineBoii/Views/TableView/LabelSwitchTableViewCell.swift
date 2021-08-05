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
        sw.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        sw.setOn(false, animated: false)
        sw.isEnabled = true
        return sw
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        addSubview(sw)
    }
    
    @objc private func switchStateDidChange(_ sender:UISwitch!) {
        if (sender.isOn) {
            sender.isOn = false
        }
        else {
            sender.isOn = true
        }
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
        sw.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        sw.setOn(true, animated: false)
        sw.isEnabled = true
        return sw
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        addSubview(sw)
        
        
    }
    
    @objc private func switchStateDidChange(_ sender:UISwitch) {
        if (sender.isOn) {
            sender.isOn = false
        }
        else {
            sender.isOn = true
        }
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
    }
    

}
