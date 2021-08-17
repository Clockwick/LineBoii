//
//  BrandViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 11/8/2564 BE.
//

import UIKit

class BrandViewController: UIViewController {
    
    lazy var contentViewSize = CGSize(width: self.view.width, height: self.view.height + 10000)
    
    private var savedPosition: CGFloat = 9999;
    
    lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: contentViewSize.width, height: 44))
        headerView.backgroundColor = .systemBackground
        headerView.layer.borderWidth = 0.25
        headerView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: contentViewSize.width / 2, height: 30))
        label.center.y = headerView.center.y
        let image = UIImage(systemName: "slider.horizontal.3")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        imageView.frame = CGRect(x: headerView.width - imageView.width - 15, y: 0, width: 20, height: 20)
        imageView.center.y = headerView.center.y
        label.text = "เลือกสาขาที่ต้องการสั่ง"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        headerView.addSubview(label)
        headerView.addSubview(imageView)
        return headerView
    }()
    
    // MARK: - Floor
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .secondarySystemBackground
        scrollView.frame = self.view.bounds
        scrollView.contentSize = contentViewSize
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.frame.size = contentViewSize
        return view
    }()
    
    private let locationTableView: UITableView = {
        let table = UITableView()
        table.register(HeaderLocationTableViewCell.self, forCellReuseIdentifier: HeaderLocationTableViewCell.identifier)
        table.isScrollEnabled = false
        return table
    }()
    
    private let brandTableView: UITableView = {
        let table = UITableView()
        table.register(BrandRestaurantTableViewCell.self, forCellReuseIdentifier: BrandRestaurantTableViewCell.identifier)
        table.isScrollEnabled = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.delegate = self
        
        locationTableView.delegate = self
        locationTableView.dataSource = self
        
        brandTableView.delegate = self
        brandTableView.dataSource = self

        contentView.addSubview(locationTableView)
        contentView.addSubview(brandTableView)
        contentView.addSubview(headerView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        locationTableView.frame = CGRect(x: 0, y: contentView.safeAreaInsets.top, width: contentView.width, height: 44)
        self.savedPosition = locationTableView.bottom + 10
        headerView.frame = CGRect(x: 0, y: locationTableView.bottom + 10, width: contentView.width, height: 44)
        brandTableView.frame = CGRect(x: 0, y: headerView.bottom, width: contentView.width, height: contentView.height)
        
    }
    
    

}


extension BrandViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.scrollView.contentOffset.y + view.safeAreaInsets.top >= self.savedPosition {
            self.headerView.frame.origin.y = self.scrollView.contentOffset.y + view.safeAreaInsets.top
            
        }
        else {
            self.headerView.frame.origin.y = self.savedPosition
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.locationTableView {
            return 1
        }
        if tableView == self.brandTableView {
            return 10
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.locationTableView {
            guard let cell = locationTableView.dequeueReusableCell(withIdentifier: HeaderLocationTableViewCell.identifier) as? HeaderLocationTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: "บ้าน")
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        if tableView == self.brandTableView {
            guard let cell = brandTableView.dequeueReusableCell(withIdentifier: BrandRestaurantTableViewCell.identifier, for: indexPath) as? BrandRestaurantTableViewCell else {
                return UITableViewCell()
            }
            let supportedType: [SupportType] = [
                .credit,
                .deliveryCharge(price: 100),
            ]
            cell.configure(with: BrandRestaurantViewModel(brandImageURL: nil, isOpen: false, title: "ซัสโก้ประชาอุทิศ", deliveryPrice: 0, deliveryTime: 20, isOfficial: true, distance: 2.7, restaurantImageURL: nil, supportType: supportedType))
            return cell

        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.brandTableView {
            return 150
        }
        return tableView.estimatedRowHeight
    }
    
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

