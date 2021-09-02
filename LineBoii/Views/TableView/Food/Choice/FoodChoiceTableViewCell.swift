//
//  FoodChoiceTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 29/8/2564 BE.
//

import UIKit

protocol FoodChoiceTableViewCellDelegate: AnyObject {
    func foodChoiceTableViewCellDidTap(_ status: Bool, indexPath: IndexPath)
    func currentSelectedChoice(_ menus: [Menu], indexPath: IndexPath)
}

class FoodChoiceTableViewCell: UITableViewCell {

    static let identifier = "FoodChoiceTableViewCell"
    
    weak var delegate: FoodChoiceTableViewCellDelegate?
    private var chevronStatus: Bool = true
    private var menus = [Menu]()
    private var currentIndexPath: IndexPath = IndexPath.init(row: -1, section: -1)
    private var currentChoice = [IndexPath: Bool]()
    private var passedIndexPath: IndexPath = IndexPath.init(row: -1, section: -1)
    private var isFirstTime: Bool = true
    
    
    @IBOutlet var menuTableView: UITableView! {
        didSet {
            menuTableView.register(UINib(nibName: String(describing: MenuChoiceTableViewCell.self), bundle: nil), forCellReuseIdentifier: MenuChoiceTableViewCell.identifier)
        }
    }
    @IBOutlet var chevronUp: UIImageView!
    @IBOutlet var chevronDown: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var requiredMark: UILabel! {
        didSet {
            requiredMark.textColor = .darkGreen
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        chevronSetup()
        menuTableViewSetup()
        
        
    }

    // MARK: - Set up
    private func chevronSetup() {
        chevronDown.tintColor = UIColor.darkGreen
        chevronUp.tintColor = UIColor.darkGreen
    }
    
    private func menuTableViewSetup() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    // MARK: - Function
    
    func configure(with viewModel: FoodAddition) {
        guard let titleLabel = titleLabel
              else {
            return
        }
        titleLabel.text = viewModel.title
        
        self.titleLabel = titleLabel
        
        self.menus = viewModel.menuId
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.menuTableView.reloadDataWithAutoSizingCellWorkAround()
        }
    }
    
    func initialize(with indexPath: IndexPath) {
        self.passedIndexPath = indexPath
    }
    
    func toggleChevron(indexPath: IndexPath) {
        self.chevronStatus = !self.chevronStatus
        
        // Display Menu
        if self.chevronStatus {
            self.chevronUp.isHidden = false
            self.chevronDown.isHidden = true
            self.menuTableView.isHidden = false
            contentView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height)
            delegate?.foodChoiceTableViewCellDidTap(true, indexPath: indexPath)
        }
        // Hide Menu
        else {
            self.chevronUp.isHidden = true
            self.chevronDown.isHidden = false
            self.menuTableView.isHidden = true
            contentView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height - self.menuTableView.height)
            delegate?.foodChoiceTableViewCellDidTap(false, indexPath: indexPath)
        }
    }
    
    func getChevronStatus() -> Bool {
        return self.chevronStatus
    }
    
    func showDefaultChoice() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let firstIndexPath = IndexPath(item: 0, section: 0)
            guard let firstCell = self.menuTableView.dequeueReusableCell(withIdentifier: MenuChoiceTableViewCell.identifier, for: firstIndexPath) as? MenuChoiceTableViewCell else {
                return 
            }
            firstCell.didTapButton()
        }
    }
}


extension FoodChoiceTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.menuTableView.dequeueReusableCell(withIdentifier: MenuChoiceTableViewCell.identifier, for: indexPath) as? MenuChoiceTableViewCell else {
            return UITableViewCell()
        }
        cell.initialize(with: indexPath, currentIndexPath: currentIndexPath)
        cell.configure(viewModel: menus[indexPath.row])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.menuTableView {
            self.menuTableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension FoodChoiceTableViewCell: MenuChoiceTableViewCellDelegate {
    func menuChoiceTableViewCellDidTap(at indexPath: IndexPath, status: Bool) {
        self.currentIndexPath = indexPath
        var newMenus = [Menu]()
        self.menus.forEach { (menu) in
            var newMenu = menu
            newMenu.status = false
            newMenus.append(newMenu)
        }
        self.menus = newMenus
        menus[indexPath.row].status = status
        delegate?.currentSelectedChoice(menus, indexPath: passedIndexPath)
        DispatchQueue.main.async {
            self.menuTableView.reloadDataWithAutoSizingCellWorkAround()
        }
        
    }
}
