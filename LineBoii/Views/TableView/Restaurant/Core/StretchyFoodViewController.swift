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
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.register(UINib(nibName: String(describing: FoodHeaderTableViewCell.self), bundle: nil), forCellReuseIdentifier: FoodHeaderTableViewCell.identifier)
        tv.register(UINib(nibName: String(describing: FoodChoiceTableViewCell.self), bundle: nil), forCellReuseIdentifier: FoodChoiceTableViewCell.identifier)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodChoiceTableViewCell.identifier, for: indexPath) as? FoodChoiceTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: self.foodAdditions[indexPath.section - 1])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return tableView.rowHeight
        }
        else {
//            guard let cell = tableView.cellForRow(at: indexPath) as? FoodChoiceTableViewCell else {
//                return tableView.rowHeight
//            }
//            let currentChevronStatus: Bool = cell.getChevronStatus()
            let heightForRowOfMenuChoice = 44
//            if currentChevronStatus {
//                // Showing, return menu choice height * menu.count + (60)
//                return CGFloat((self.foodAdditions[indexPath.section - 1].menuId.count * heightForRowOfMenuChoice) + 40)
//            }
            // If Hiding, return dynamic
            return CGFloat((self.foodAdditions[indexPath.section - 1].menuId.count * heightForRowOfMenuChoice) + 110)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            break
        default:
            let cell = tableView.cellForRow(at: indexPath) as? FoodChoiceTableViewCell
            cell?.toggleChevron()
        }
        
    }
    
    
}
