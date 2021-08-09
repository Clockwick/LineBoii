//
//  PriceSelectorViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 7/8/2564 BE.
//

import UIKit

class PriceSelectorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.isScrollEnabled = false
        table.separatorColor = .clear
        table.register(ButtonsTableViewCell.self, forCellReuseIdentifier: ButtonsTableViewCell.identifier)
        table.register(SearchButtonTableViewCell.self, forCellReuseIdentifier: SearchButtonTableViewCell.identifier)
        return table
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = .systemBackground
//        navigationController?.isNavigationBarHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        

    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height) // 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonsTableViewCell.identifier, for: indexPath) as! ButtonsTableViewCell
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchButtonTableViewCell.identifier, for: indexPath) as! SearchButtonTableViewCell
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 60))
            headerView.backgroundColor = .systemBackground
            let label = UILabel(frame: CGRect(x: 15, y: 0, width: headerView.width, height: 30))
            label.text = "ราคา"
            label.textColor = .label
            label.font = UIFont(name: "supermarket", size: 20)
            
            headerView.addSubview(label)
            return headerView
        }
        return UIView()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



class ButtonsTableViewCell: UITableViewCell {
    
    static let identifier = "ButtonsTableViewCell"
    
    private let pricelessButton = GreenWhiteButton()
    private let cheapButton = GreenWhiteButton()
    private let mediumButton = GreenWhiteButton()
    private let expensiveButton = GreenWhiteButton()
    private let highclassButton = GreenWhiteButton()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let xOffset = CGFloat(20)
        
        let pricelessString = "฿"
        let cheapString = "฿฿"
        let mediumString = "฿฿฿"
        let expensiveString = "฿฿฿฿"
        let highclassString = "฿฿฿฿฿"
        
        let pricelessButtonSize = pricelessString.size(withAttributes: [.font: UIFont(name: "supermarket", size: 16) as Any])
        let cheapButtonSize = cheapString.size(withAttributes: [.font: UIFont(name: "supermarket", size: 16) as Any])
        let mediumButtonSize = mediumString.size(withAttributes: [.font: UIFont(name: "supermarket", size: 16) as Any])
        let expensiveButtonSize = expensiveString.size(withAttributes: [.font: UIFont(name: "supermarket", size: 16) as Any])
        let highclassButtonSize = highclassString.size(withAttributes: [.font: UIFont(name: "supermarket", size: 16) as Any])
        
        // Bad programming SRY origin don't do its duty
        pricelessButton.frame = CGRect(x: 20, y: 5, width: pricelessButtonSize.width + 20, height: height - 10)
        cheapButton.frame = CGRect(x: 20 + pricelessButton.width + xOffset, y: 5, width: cheapButtonSize.width + 20, height: contentView.height - 10)
        mediumButton.frame = CGRect(x: 20 + pricelessButton.width + cheapButton.width + xOffset + xOffset, y: 5, width: mediumButtonSize.width + 20, height: contentView.height - 10)
        expensiveButton.frame = CGRect(x: 20 + pricelessButton.width + cheapButton.width + mediumButton.width + xOffset + xOffset + xOffset, y: 5, width: expensiveButtonSize.width + 20, height: contentView.height - 10)
        highclassButton.frame = CGRect(x: 20 + pricelessButton.width + cheapButton.width + mediumButton.width + expensiveButton.width + xOffset + xOffset + xOffset + xOffset, y: 5, width: highclassButtonSize.width + 20, height: contentView.height - 10)
    }
    
    private func configureButtons() {
        var pricelessStatus: ButtonState = .none
        var cheapStatus: ButtonState = .none
        var mediumStatus: ButtonState = .none
        var expensiveStatus: ButtonState = .none
        var highclassStatus: ButtonState = .none
        
        let priceLevelArray = RestaurantFilterManager.shared.priceLevelArray
        
        for priceLevel in priceLevelArray {
            switch priceLevel {
            case .priceless:
                pricelessStatus = .active
            case .cheap:
                cheapStatus = .active
            case .medium:
                mediumStatus = .active
            case .expensive:
                expensiveStatus = .active
            case .highclass:
                highclassStatus = .active
            }
        }
        
        let pricelessString = "฿"
        let cheapString = "฿฿"
        let mediumString = "฿฿฿"
        let expensiveString = "฿฿฿฿"
        let highclassString = "฿฿฿฿฿"
        
        let pricelessButtonSize = pricelessString.size(withAttributes: [.font: UIFont(name: "supermarket", size: 16) as Any])
        let cheapButtonSize = cheapString.size(withAttributes: [.font: UIFont(name: "supermarket", size: 16) as Any])
        let mediumButtonSize = mediumString.size(withAttributes: [.font: UIFont(name: "supermarket", size: 16) as Any])
        let expensiveButtonSize = expensiveString.size(withAttributes: [.font: UIFont(name: "supermarket", size: 16) as Any])
        let highclassButtonSize = highclassString.size(withAttributes: [.font: UIFont(name: "supermarket", size: 16) as Any])
        
        contentView.addSubview(pricelessButton)
        contentView.addSubview(cheapButton)
        contentView.addSubview(mediumButton)
        contentView.addSubview(expensiveButton)
        contentView.addSubview(highclassButton)
        
        pricelessButton.configure(with: pricelessString, size: CGSize(width: pricelessButtonSize.width + 20, height: contentView.height - 10), priceLevel: .priceless, status: pricelessStatus)
        cheapButton.configure(with: cheapString, size: CGSize(width: cheapButtonSize.width + 20, height: contentView.height - 10), priceLevel: .cheap, status: cheapStatus)
        mediumButton.configure(with: mediumString, size: CGSize(width: mediumButtonSize.width + 20, height: contentView.height - 10), priceLevel: .medium, status: mediumStatus)
        expensiveButton.configure(with: expensiveString, size: CGSize(width: expensiveButtonSize.width + 20, height: contentView.height - 10), priceLevel: .expensive, status: expensiveStatus)
        highclassButton.configure(with: highclassString, size: CGSize(width: highclassButtonSize.width + 20, height: contentView.height - 10), priceLevel: .highclass, status: highclassStatus)
        
        let xOffset = CGFloat(20)
        
        // Bad programming SRY origin don't do its duty
        pricelessButton.frame = CGRect(x: 20, y: 5, width: pricelessButtonSize.width + 20, height: height - 10)
        cheapButton.frame = CGRect(x: 20 + pricelessButton.width + xOffset, y: 5, width: cheapButtonSize.width + 20, height: contentView.height - 10)
        mediumButton.frame = CGRect(x: 20 + pricelessButton.width + cheapButton.width + xOffset + xOffset, y: 5, width: mediumButtonSize.width + 20, height: contentView.height - 10)
        expensiveButton.frame = CGRect(x: 20 + pricelessButton.width + cheapButton.width + mediumButton.width + xOffset + xOffset + xOffset, y: 5, width: expensiveButtonSize.width + 20, height: contentView.height - 10)
        highclassButton.frame = CGRect(x: 20 + pricelessButton.width + cheapButton.width + mediumButton.width + expensiveButton.width + xOffset + xOffset + xOffset + xOffset, y: 5, width: highclassButtonSize.width + 20, height: contentView.height - 10)
        
        
        
    }
    
}

class SearchButtonTableViewCell: UITableViewCell {
    
    static let identifier = "SearchButtonTableViewCell"
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("ค้นหา", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGreen
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(searchButton)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchButton.frame = CGRect(x: 10, y: 0, width: width - 20, height: 50)
    }
    
}

extension PriceSelectorViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

