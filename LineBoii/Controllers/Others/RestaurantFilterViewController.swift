//
//  RestaurantFilterViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 5/8/2564 BE.
//

import UIKit

class RestaurantFilterViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        // Label with Switch
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(LabelSwitchTableViewCell.self, forCellReuseIdentifier: LabelSwitchTableViewCell.identifier)
        table.register(BoldLabelSwitchTableViewCell.self, forCellReuseIdentifier: BoldLabelSwitchTableViewCell.identifier)
        table.register(ButtonsTableViewCell.self, forCellReuseIdentifier: ButtonsTableViewCell.identifier)
        // Buttons
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ตัวกรอง"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ล้างค่า", style: .done, target: self, action: #selector(didTapClearAll))
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc private func didTapClearAll() {
        for cell in tableView.visibleCells {
            if let boldCell = cell as? BoldLabelSwitchTableViewCell{
                boldCell.turnOff()
            }
            if let mycell = cell as? LabelSwitchTableViewCell{
                mycell.turnOff()
            }
        }
        
        NotificationCenter.default.post(name: .clearFilterAllNotification, object: nil)
        RestaurantFilterManager.shared.clearPriceLevel()
        RestaurantFilterManager.shared.calculateCurrentSelectedItems()
        NotificationCenter.default.post(name: .filterChangeNotification, object: nil)
    }

}

extension RestaurantFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            // Bold Label Switch
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BoldLabelSwitchTableViewCell.identifier, for: indexPath) as? BoldLabelSwitchTableViewCell else {
                return UITableViewCell()
            }
            let switchStatus = RestaurantFilterManager.shared.isOpen
            cell.contentView.isUserInteractionEnabled = false
            cell.configure(with: LabelSwitchViewModel(title: "ร้านอาหารที่เปิดเท่านั้น"))
            cell.setSwitchStatus(status: switchStatus)
            return cell
            
        case 1:
            // Label Switch
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelSwitchTableViewCell.identifier, for: indexPath) as? LabelSwitchTableViewCell else {
                return UITableViewCell()
            }
            let switchStatus = RestaurantFilterManager.shared.isAllowCreditCard
            cell.contentView.isUserInteractionEnabled = false
            cell.configure(with: LabelSwitchViewModel(title: "บัตรเครดิต"), type: .isAllowCreditCard)
            cell.setSwitchStatus(status: switchStatus)
            return cell
            
        case 2:
            // Label Switch
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelSwitchTableViewCell.identifier, for: indexPath) as? LabelSwitchTableViewCell else {
                return UITableViewCell()
            }
            let switchStatus = RestaurantFilterManager.shared.isPromotion
            cell.contentView.isUserInteractionEnabled = false
            cell.configure(with: LabelSwitchViewModel(title: "โปรโมชั่น"), type: .isPromotion)
            cell.setSwitchStatus(status: switchStatus)
            return cell
        case 3:
            // Label Switch
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelSwitchTableViewCell.identifier, for: indexPath) as? LabelSwitchTableViewCell else {
                return UITableViewCell()
            }
            let switchStatus = RestaurantFilterManager.shared.isPickable
            cell.contentView.isUserInteractionEnabled = false
            cell.configure(with: LabelSwitchViewModel(title: "รับที่ร้าน"), type: .isPickable)
            cell.setSwitchStatus(status: switchStatus)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonsTableViewCell.identifier, for: indexPath) as! ButtonsTableViewCell
            cell.selectionStyle = .none
            return cell
//        case 5:
////            return "ประเภทอาหาร"
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        
        case 1:
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 35))
            headerView.backgroundColor = .systemBackground
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: headerView.width, height: headerView.height))
            label.text = "ชำระเงิน"
            label.textColor = .label
            label.font = .systemFont(ofSize: 16, weight: .bold)
            headerView.addSubview(label)
            return headerView
        case 2:
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 35))
            headerView.backgroundColor = .systemBackground
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: headerView.width, height: headerView.height))
            label.text = "โปรโมชั่น"
            label.textColor = .label
            label.font = .systemFont(ofSize: 16, weight: .bold)
            headerView.addSubview(label)
            return headerView
        case 3:
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 35))
            headerView.backgroundColor = .systemBackground
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: headerView.width, height: headerView.height))
            label.text = "ประเภทออเดอร์"
            label.textColor = .label
            label.font = .systemFont(ofSize: 16, weight: .bold)
            headerView.addSubview(label)
            return headerView
        case 4:
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 35))
            headerView.backgroundColor = .systemBackground
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: headerView.width, height: headerView.height))
            label.text = "ราคา"
            label.textColor = .label
            label.font = .systemFont(ofSize: 16, weight: .bold)
            headerView.addSubview(label)
            return headerView
        case 5:
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 35))
            headerView.backgroundColor = .systemBackground
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: headerView.width, height: headerView.height))
            label.text = "ประเภทอาหาร"
            label.textColor = .label
            label.font = .systemFont(ofSize: 16, weight: .bold)
            headerView.addSubview(label)
            return headerView
        default:
            return UIView(frame: .zero)
        }
        
    }
}
