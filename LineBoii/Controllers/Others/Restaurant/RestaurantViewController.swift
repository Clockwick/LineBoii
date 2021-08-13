//
//  RestaurantViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 13/8/2564 BE.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    var restaurantName: String = ""
    
    private let restaurantInfoTableView: UITableView = {
        let table = UITableView()
        table.separatorColor = .clear
        table.isScrollEnabled = false
        table.register(OfficialAndInformationTableViewCell.self, forCellReuseIdentifier: OfficialAndInformationTableViewCell.identifier)
        table.register(TimeShareLoveTableViewCell.self, forCellReuseIdentifier: TimeShareLoveTableViewCell.identifier)
        table.register(PickableBannerTableViewCell.self, forCellReuseIdentifier: PickableBannerTableViewCell.identifier)
        table.register(RestaurantImageTableViewCell.self, forCellReuseIdentifier: RestaurantImageTableViewCell.identifier)
        // Register
        /**
         Section 0 :
         1. Official + Information
         2. Open and close time + Share + Love
         3. Is pickable banner
         4. Restaurant Image View
         
         Section 1:
         1. Collection View Flow layout Horizontal
         2.
         */
        
        return table
    }()
    
    private let foodTableView: UITableView = {
        let table = UITableView()
        /**
         1.Section Header
            1.1 FoodPreviewTableViewCell
                1.1.1 FoodImageURL
                ...
         
            
         */
        return table
    }()
    
    
    
    lazy var restaurantNameLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: self.restaurantName)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.attributedText = attrString
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        
        restaurantInfoTableView.delegate = self
        restaurantInfoTableView.dataSource = self
        
        view.addSubview(restaurantNameLabel)
        view.addSubview(restaurantInfoTableView)

    }
    
    func configureModel() {
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        restaurantNameLabel.frame = CGRect(x: 15, y: view.safeAreaInsets.top - 20, width: view.width, height: 150)
        restaurantInfoTableView.frame = CGRect(x: 10, y: restaurantNameLabel.bottom - 20, width: view.width - 20, height: 1000)
    }

}

extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.restaurantInfoTableView {
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.restaurantInfoTableView {
            let row = indexPath.row
            switch row {
            case 0:
                guard let cell = restaurantInfoTableView.dequeueReusableCell(withIdentifier: OfficialAndInformationTableViewCell.identifier, for: indexPath) as? OfficialAndInformationTableViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
            case 1:
                guard let cell = restaurantInfoTableView.dequeueReusableCell(withIdentifier: TimeShareLoveTableViewCell.identifier, for: indexPath) as? TimeShareLoveTableViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.configure(with: "20:00")
                return cell
            case 2:
                guard let cell = restaurantInfoTableView.dequeueReusableCell(withIdentifier: PickableBannerTableViewCell.identifier, for: indexPath) as? PickableBannerTableViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.configure(with: 2.5)
                return cell
            case 3:
                guard let cell = restaurantInfoTableView.dequeueReusableCell(withIdentifier: RestaurantImageTableViewCell.identifier, for: indexPath) as? RestaurantImageTableViewCell else {
                    return UITableViewCell()
                }
                let supportTypes: [SupportType] = [
                    .credit,
                    .deliveryCharge(price: 10),
                    .promotion
                ]
                cell.configure(with: RestaurantImageViewModel(imageURL: nil, supportTypes: supportTypes))
                return cell
            default:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.restaurantInfoTableView {
            let row = indexPath.row
            switch row {
            
            case 3:
                return CGFloat(250)
            default:
                return tableView.estimatedRowHeight
            }
        }
        return tableView.estimatedRowHeight
    }
    
    
    
    
}
