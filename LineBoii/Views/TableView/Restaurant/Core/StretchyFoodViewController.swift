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
        stretchyFoodHeaderView.expansionMode = .immediate
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
        // + 1 Because Header
        return self.foodAdditions.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfFoodAdditions = self.foodAdditions.count - 1
        return numberOfFoodAdditions
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodCheckboxTableViewCell.identifier, for: indexPath) as? FoodCheckboxTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: self.foodAdditions[indexPath.section - 1])
            cell.delegate = self
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return tableView.estimatedRowHeight
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
            // Default Height for Row of inactive Menu bar
            return 100
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            break
        default:
            let cell = tableView.cellForRow(at: indexPath) as? FoodCheckboxTableViewCell
            cell?.toggleChevron(indexPath: indexPath)
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
