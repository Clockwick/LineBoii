//
//  FoodChoiceTableViewCell.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 27/8/2564 BE.
//

import UIKit


protocol FoodChoiceTableViewCellDelegate: AnyObject {
    func foodChoiceTableViewCellDidTap(_ status: Bool, indexPath: IndexPath)
}

class FoodChoiceTableViewCell: UITableViewCell {
    static let identifier = "FoodChoiceTableViewCell"
    
    weak var delegate: FoodChoiceTableViewCellDelegate?
    
    private var chevronStatus: Bool = true
    private var menus = [Menu]()
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var chevronDown: UIImageView!
    @IBOutlet var chevronUp: UIImageView!
    @IBOutlet var menuTableView: UITableView! {
        didSet {
            menuTableView.register(UINib(nibName: String(describing: MenuChoiceTableViewCell.self), bundle: nil), forCellReuseIdentifier: MenuChoiceTableViewCell.identifier)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        chevronSetup()
        menuTableViewSetup()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        guard let titleLabel = titleLabel,
              let subtitleLabel = subtitleLabel else {
            return
        }
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        self.titleLabel = titleLabel
        self.subtitleLabel = subtitleLabel
        
        self.menus = viewModel.menuId
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
//        setNeedsLayout()
    }
    
    func getChevronStatus() -> Bool {
        return self.chevronStatus
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
        cell.configure(viewModel: menus[indexPath.row])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.menuTableView {
            self.menuTableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
}
