//
//  StretchyFoodViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 27/8/2564 BE.
//

import UIKit
import GSKStretchyHeaderView

class StretchyFoodViewController: UIViewController{
    
    private var stretchyFoodHeaderView: StretchyFoodHeaderView?
    private var viewModel: FoodViewModel?
    private var foodAdditions = [FoodAddition]()
    
    private var sectionsHeightForRow = [Int: CGFloat]()
    private var sectionsStatusForRow = [Int: Bool]()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.register(UINib(nibName: String(describing: FoodHeaderTableViewCell.self), bundle: nil), forCellReuseIdentifier: FoodHeaderTableViewCell.identifier)
        tv.register(UINib(nibName: String(describing: FoodCheckboxTableViewCell.self), bundle: nil), forCellReuseIdentifier: FoodCheckboxTableViewCell.identifier)
        tv.register(UINib(nibName: String(describing: FoodChoiceTableViewCell.self), bundle: nil), forCellReuseIdentifier: FoodChoiceTableViewCell.identifier)
        tv.register(UINib(nibName: String(describing: FoodAdditionalDetailTableViewCell.self), bundle: nil), forCellReuseIdentifier: FoodAdditionalDetailTableViewCell.identifier)
        tv.register(UINib(nibName: String(describing: BucketTableViewCell.self), bundle: nil), forCellReuseIdentifier: BucketTableViewCell.identifier)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        setupStretchyHeader()
        
    }
    
    private func setupStretchyHeader() {
        let headerSize = CGSize(width: self.view.width, height: 400)
        self.stretchyFoodHeaderView = StretchyFoodHeaderView(frame: CGRect(x: 0, y: 0, width: headerSize.width, height: headerSize.height))
        guard let stretchyFoodHeaderView = self.stretchyFoodHeaderView, let viewModel = self.viewModel else {
            return
        }
        stretchyFoodHeaderView.maximumContentHeight = CGFloat(400)
        stretchyFoodHeaderView.minimumContentHeight = CGFloat(75)
        stretchyFoodHeaderView.initialize(with: viewModel, vc: self)
        
        tableView.addSubview(stretchyFoodHeaderView)
    }
    
    
    @objc private func didTapQuit() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    func configure(with viewModel: FoodViewModel) {
        self.viewModel = viewModel
        self.foodAdditions = viewModel.foodAdditionId
        for (index, foodAddition) in self.foodAdditions.enumerated() {
            // SKIP Header
            let index = index + 1
            self.sectionsHeightForRow[index] = calcHeight(from: foodAddition.menuId)
        }
        
        
    }
    
    private func calcHeight(from menus: [Menu]) -> CGFloat {
        var result = 0
        let heightForRowOfMenuChoice = 44
        let spacing = 110
        for _ in menus {
            result += heightForRowOfMenuChoice
        }
        result += spacing
        return CGFloat(result)
    }
    
}


extension StretchyFoodViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // + 3 Because Header, Additional Detail, Add to cart
        return self.foodAdditions.count + 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textFieldSection = tableView.numberOfSections - 2
        let addToCartSection = tableView.numberOfSections - 1
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodHeaderTableViewCell.identifier, for: indexPath) as? FoodHeaderTableViewCell,
                  let title = viewModel?.title,
                  let subtitle = viewModel?.subtitle else {
                return UITableViewCell()
            }
            cell.configure(title: title, subtitle: subtitle)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
            
        case textFieldSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodAdditionalDetailTableViewCell.identifier, for: indexPath) as? FoodAdditionalDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case addToCartSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BucketTableViewCell.identifier, for: indexPath) as? BucketTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        default:
            let type = self.foodAdditions[indexPath.section - 1].type
            switch type {
            case .checkbox:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodCheckboxTableViewCell.identifier, for: indexPath) as? FoodCheckboxTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: self.foodAdditions[indexPath.section - 1])
                cell.delegate = self
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                return cell
            case .choice:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodChoiceTableViewCell.identifier, for: indexPath) as? FoodChoiceTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: self.foodAdditions[indexPath.section - 1])
                cell.delegate = self
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                return cell
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let textFieldSection = tableView.numberOfSections - 2
        let addToCartSection = tableView.numberOfSections - 1
        if indexPath.section == 0 {
            return tableView.estimatedRowHeight
        }
        
        if indexPath.section == textFieldSection {
            return 120
        }
        
        if indexPath.section == addToCartSection {
            return 150
        }
        else {
            guard let status = self.sectionsStatusForRow[indexPath.section] else {
                // First Appearance
                return sectionsHeightForRow[indexPath.section]!
            }
            if status {
                // Dynamic Height for Row
                return sectionsHeightForRow[indexPath.section]!
            }
//            // Default Height for Row of inactive Menu bar
            let type = self.foodAdditions[indexPath.section - 1].type
            switch type {
            case .choice:
                return 70
            case .checkbox:
                return 100
            }
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let textFieldSection = tableView.numberOfSections - 2
        let addToCartSection = tableView.numberOfSections - 1
        switch indexPath.section {
        case 0:
            break
        case textFieldSection:
            break
        case addToCartSection:
            break
        default:
            let type = self.foodAdditions[indexPath.section - 1].type
            switch type {
            case .checkbox:
                let cell = tableView.cellForRow(at: indexPath) as? FoodCheckboxTableViewCell
                cell?.toggleChevron(indexPath: indexPath)
            case .choice:
                let cell = tableView.cellForRow(at: indexPath) as? FoodChoiceTableViewCell
                cell?.toggleChevron(indexPath: indexPath)
            }
            
        }
        
    }
    
}


extension StretchyFoodViewController: FoodCheckboxTableViewCellDelegate {
    func foodCheckboxTableViewCellDidTap(_ status: Bool, indexPath: IndexPath) {
        self.sectionsStatusForRow[indexPath.section] = status
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension StretchyFoodViewController: FoodChoiceTableViewCellDelegate {
    func foodChoiceTableViewCellDidTap(_ status: Bool, indexPath: IndexPath) {
        self.sectionsStatusForRow[indexPath.section] = status
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
