//
//  RestaurantViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 13/8/2564 BE.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    var restaurantName: String = ""
    
    private var restaurantCategories = [RestaurantCategoryViewModel]()
    
    private var headerRestaurantViewModel: RestaurantViewModel?
    
    lazy var contentViewSize = CGSize(width: self.view.width, height: self.view.height + 10000)
    
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
         */
        
        return table
    }()
    
    private let foodTableView: UITableView = {
        let table = UITableView()
        table.register(FoodTableViewCell.self, forCellReuseIdentifier: FoodTableViewCell.identifier)
        return table
    }()
    
    // MARK: - Floor
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .systemBackground
        scrollView.frame = self.view.bounds
        scrollView.contentSize = contentViewSize
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.frame.size = contentViewSize
        return view
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
    
    private let headerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.allowsSelection = true
        cv.backgroundColor = .systemBackground
        // Register
        cv.register(RestaurantHeaderCollectionViewCell.self, forCellWithReuseIdentifier: RestaurantHeaderCollectionViewCell.identifier)
        
        return cv
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        
        restaurantInfoTableView.delegate = self
        restaurantInfoTableView.dataSource = self
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        foodTableView.delegate = self
        foodTableView.dataSource = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(restaurantNameLabel)
        contentView.addSubview(restaurantInfoTableView)
        
        contentView.addSubview(headerCollectionView)
        contentView.addSubview(foodTableView)
    }
    
    
    
    func fetchData() {
        
        
        // Top section
        let deliveryPrice = 10
        
        var dailyOpenTime = DateComponents()
        dailyOpenTime.hour = 9
        dailyOpenTime.minute = 0
        
        let dailyOpenTimeDate = NSCalendar.current.date(from: dailyOpenTime)!
        
        var dailyCloseTime = DateComponents()
        dailyCloseTime.hour = 20
        dailyCloseTime.minute = 0
        
        let dailyCloseTimeDate = NSCalendar.current.date(from: dailyCloseTime)!
        
        let supportTypes: [SupportType] = [
            .credit,
            .deliveryCharge(price: deliveryPrice),
            .promotion
        ]
        
        self.headerRestaurantViewModel = RestaurantViewModel(name: self.restaurantName, timeDelivery: "30", deliveryPrice: 20, supportedTypes: supportTypes, isOfficial: true, dailyOpenTime: dailyOpenTimeDate, dailyClosedTime: dailyCloseTimeDate, isPickUp: true, distance: 2.5, restaurantImageURL: nil, foodCategories: nil)
        
        // Menus
        
        let c1_f1_a1_m1 = Menu(name: "แจ่วหมากแหล่นสูตรปากเซ", price: 35)
        let c1_f1_a1_m2 = Menu(name: "แจ่วบองปลาร้าสูตรปากเซ", price: 35)
        
        let c2_f1_a1_m1 = Menu(name: "แจ่วหมากแหล่นสูตรปากเซ", price: 35)
        let c2_f1_a1_m2 = Menu(name: "แจ่วบองปลาร้าสูตรปากเซ", price: 35)
        
        let menusC1: [Menu] = [c1_f1_a1_m1, c1_f1_a1_m2]
        let menusC2: [Menu] = [c2_f1_a1_m1, c2_f1_a1_m2]
        
        // Food Addition
        let c1_f1_a1 = FoodAddition(title: "เพิ่ม", subtitle: "เลือกสูงสุด 1 ข้อ", type: .checkbox, menuId: menusC1)
        let c2_f1_a1 = FoodAddition(title: "เพิ่ม", subtitle: "เลือกสูงสุด 1 ข้อ", type: .checkbox, menuId: menusC2)
        
        let foodAddtionalsC1: [FoodAddition] = [c1_f1_a1]
        let foodAddtionalsC2: [FoodAddition] = [c2_f1_a1]
        
        
        // Food
        let c1_f1 = Food(foodImageURL: nil, title: "แถมฟรี! ส้มตำ 1 ครก เมื่อสั่งเมี่ยงปลาเผา 1 ชุด", subtitle: nil, foodAdditionId: foodAddtionalsC1)
        let c2_f1 = Food(foodImageURL: nil, title: "โปรพิเศษ สั่งปิ้งไก่นาปง 1 ตัว ฟรี!! ข้าวเหนียว+ส้มตำ", subtitle: "เลือกฟรี!! ตำไทย ตำปู ตำลาว ระบุให้พ่อค่าหน่อยนะครับ ขอบพระคุณมากนะครับผม", foodAdditionId: foodAddtionalsC2)
        
        let foodsC1: [Food] = [c1_f1]
        let foodsC2: [Food] = [c2_f1]
        
        // Restaurant Category section
        let c1 = RestaurantCategoryViewModel(id: "1",header: "โปรโมชั่น", foodId: foodsC1, status: .active)
        let c2 = RestaurantCategoryViewModel(id: "2",header: "โปรอิ่มสุดปัง..ฟรี!!ข้าวเหนียว+ส้มตำ เมื่อซื้อปิ้งไก่นาปงสูตรพิเศษ 1 ตัว", foodId: foodsC2)
//        let c3 = RestaurantCategory(header: "โปร 1 แถม 1 สั่งเมี่ยงปลาเผา1ฟรี!!ตำลาก1ครก", foodId: [Food])
//        let c4 = RestaurantCategory(header: "[อร่อยซ่ากับโค้ก] ปิ้งไก่เทปง(ครึ่งตัว)+ข้าวเหนียว+ส้มตำ+ฟรีโค้ก", foodId: [Food])
//        let c5 = RestaurantCategory(header: "เซตเนื้อแดดเดียวแจ่วปลาร้าโบราณ ฟรี!!ข้าวเหนียว ผักสด น้ำเก็กฮวย", foodId: [Food])
//        let c6 = RestaurantCategory(header: "เซตหมูแดดเดียว แจ่วปลาร้าโบราณ ฟรี!!ข้าวเหนียว ผักสด น้ำเก็กฮวย", foodId: [Food])
//        let c7 = RestaurantCategory(header: "เซตหมูย่างถ่าน ตลาดเช้า แจ่วสูตรลับปากเซ ฟรี!! ข้าวเหนียว ผักสด", foodId: [Food])
//        let c9 = RestaurantCategory(header: "เซตเมี่ยงปลาเผาไซส์ใหญ่ แจ่วปากเซ", foodId: [Food])
//        let c10 = RestaurantCategory(header: "ตำมิตรภาพไทย-ลาว แซ่บนัว", foodId: [Food])
//        let c11 = RestaurantCategory(header: "ปิ้งๆย่างๆหอมๆแซ่บๆ", foodId: [Food])
//        let c12 = RestaurantCategory(header: "ต้มแซ่บ อ่อม ต้มยำ ต้มโคล้ง รสจัดจ้าน", foodId: [Food])
//        let c13 = RestaurantCategory(header: "ยำยั่วๆแซ่บปากเซ", foodId: [Food])
//        let c14 = RestaurantCategory(header: "ทอดๆกรอบๆเพลินๆ", foodId: [Food])
//        let c15 = RestaurantCategory(header: "ทะเลลาว สดใหม่ใหญ่ทุกวัน", foodId: [Food])
//        let c16 = RestaurantCategory(header: "ผัดฉ่า", foodId: [Food])
//        let c17 = RestaurantCategory(header: "เครื่องดื่มเย็น ๆ ชี่นใจ", foodId: [Food])
        
        self.restaurantCategories = [c1,c2]
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        restaurantNameLabel.frame = CGRect(x: 15, y: contentView.safeAreaInsets.top - 20, width: contentView.width - 30, height: 150)
        restaurantInfoTableView.frame = CGRect(x: 10, y: restaurantNameLabel.bottom - 20, width: contentView.width - 20, height: 400)
        headerCollectionView.frame = CGRect(x: 0, y: restaurantInfoTableView.bottom + 10, width: contentView.width, height: 70)
        foodTableView.frame = CGRect(x: 10, y: headerCollectionView.bottom, width: contentView.width - 20, height: 2000)
        
    }

}

extension RestaurantViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.restaurantCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = headerCollectionView.dequeueReusableCell(withReuseIdentifier: RestaurantHeaderCollectionViewCell.identifier, for: indexPath) as? RestaurantHeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: self.restaurantCategories[indexPath.row])
        cell.delegate = self
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let font: UIFont = .systemFont(ofSize: 20)
        let buttonTextSize = self.restaurantCategories[indexPath.row].header.size(withAttributes: [.font: font as Any])
        return CGSize(width: buttonTextSize.width + 10, height: headerCollectionView.height)
    }
    
}

extension RestaurantViewController: RestaurantHeaderCollectionViewCellDelegate {
    func restaurantHeaderCollectionViewCellDidTapButton(_ id: String, status: ButtonState) {
        for (index, _ ) in self.restaurantCategories.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
                guard let cell = headerCollectionView.cellForItem(at: indexPath) as? RestaurantHeaderCollectionViewCell else {
                    return
                }
                self.restaurantCategories[index].status = .none
                cell.configure(with: self.restaurantCategories[indexPath.row])
        }
        
        for (index, item) in self.restaurantCategories.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            if item.id == id {
                guard let cell = headerCollectionView.cellForItem(at: indexPath) as? RestaurantHeaderCollectionViewCell else {
                    return
                }
                self.restaurantCategories[index].status = .active
                cell.configure(with: self.restaurantCategories[indexPath.row])
                self.headerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
    }
}

extension RestaurantViewController: UIScrollViewDelegate {
    
}

extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.foodTableView {
            return self.restaurantCategories.count
        }
        return 1
    }
    
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
                guard let cell = restaurantInfoTableView.dequeueReusableCell(withIdentifier: TimeShareLoveTableViewCell.identifier, for: indexPath) as? TimeShareLoveTableViewCell, let headerRestaurantViewModel = headerRestaurantViewModel else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                
                let dailyCloseTimeFormat = DateFormatter.timeFormatter.string(from: headerRestaurantViewModel.dailyClosedTime)
                cell.configure(with: dailyCloseTimeFormat)
                return cell
            case 2:
                guard let cell = restaurantInfoTableView.dequeueReusableCell(withIdentifier: PickableBannerTableViewCell.identifier, for: indexPath) as? PickableBannerTableViewCell, let headerRestaurantViewModel = headerRestaurantViewModel else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.configure(with: headerRestaurantViewModel.distance)
                return cell
            case 3:
                guard let cell = restaurantInfoTableView.dequeueReusableCell(withIdentifier: RestaurantImageTableViewCell.identifier, for: indexPath) as? RestaurantImageTableViewCell, let headerRestaurantViewModel = headerRestaurantViewModel else {
                    return UITableViewCell()
                }
                
                cell.configure(with: RestaurantImageViewModel(imageURL: headerRestaurantViewModel.restaurantImageURL, supportTypes: headerRestaurantViewModel.supportedTypes))
                return cell
            default:
                return UITableViewCell()
            }
        }
        if tableView == self.foodTableView {
            let section = indexPath.section
            let row = indexPath.row
            guard let cell = foodTableView.dequeueReusableCell(withIdentifier: FoodTableViewCell.identifier, for: indexPath) as? FoodTableViewCell else {
                return UITableViewCell()
            }
            let foods = self.restaurantCategories.compactMap({ $0.foodId })[section][row]
            cell.configure(with: foods)
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.foodTableView {
            return self.restaurantCategories[section].header
        }
        return ""
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
