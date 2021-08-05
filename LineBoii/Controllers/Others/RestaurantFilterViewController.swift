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
    }

}

extension RestaurantFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "ชำระเงิน"
        case 2:
            return "โปรโมชั่น"
        case 3:
            return "ประเภทออเดอร์"
        case 4:
            return "ราคา"
        case 5:
            return "ประเภทอาหาร"
        default:
            return ""
        }
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
            cell.contentView.isUserInteractionEnabled = false
            cell.configure(with: LabelSwitchViewModel(title: "ร้านอาหารที่เปิดเท่านั้น"))
            return cell
            
        case 1:
            // Label Switch
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelSwitchTableViewCell.identifier, for: indexPath) as? LabelSwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.contentView.isUserInteractionEnabled = false
            cell.configure(with: LabelSwitchViewModel(title: "บัตรเครดิต"))
            return cell
            
        case 2:
            // Label Switch
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelSwitchTableViewCell.identifier, for: indexPath) as? LabelSwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.contentView.isUserInteractionEnabled = false
            cell.configure(with: LabelSwitchViewModel(title: "โปรโมชั่น"))
            return cell
        case 3:
            // Label Switch
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelSwitchTableViewCell.identifier, for: indexPath) as? LabelSwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.contentView.isUserInteractionEnabled = false
            cell.configure(with: LabelSwitchViewModel(title: "รับที่ร้าน"))
            return cell
//        case 4:
////            return "ราคา"
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
}
