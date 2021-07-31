//
//  OrderFoodViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 30/7/2564 BE.
//

import UIKit

class OrderFoodViewController: UIViewController {
    
    private var advertisementPhotos = [String]()
    private var promotionCell = [PromotionCollectionViewCellViewModel]()
    
    private var currentAdvertisementIndex = 0
    
    private var couponAmount = 0
    
    lazy var contentViewSize = CGSize(width: self.view.width, height: self.view.height + 1000)
    
    
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
    
    private let advertisementPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .tertiaryLabel
        pageControl.currentPageIndicatorTintColor = .label

        return pageControl
    }()
    
    private var promotionCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
        return OrderFoodViewController.createSectionLayout(section: sectionIndex)
    }))
    
    private var advertisementCollectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _ ) -> NSCollectionLayoutSection? in
            return CollectionView.createSectionLayout(section: sectionIndex)
        })
    )
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(HeaderLocationTableViewCell.self, forCellReuseIdentifier: HeaderLocationTableViewCell.identifier)
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return table
    }()
    
    private let imageView: UIImageView = {
        let image = UIImage(systemName: "photo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    private let couponImageView: UIImageView = {
        let image = UIImage(named: "coupon")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var couponLabel: UILabel = {
        let label = UILabel()
        label.text = "คุณมีคูปองส่วนลด \(self.couponAmount) ใบ"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .label
        return label
    }()
    
    // MARK: - Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.backgroundColor = .secondarySystemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    
        contentView.addSubview(tableView)
        contentView.addSubview(imageView)
        contentView.addSubview(advertisementPageControl)
        contentView.addSubview(couponImageView)
        contentView.addSubview(couponLabel)
        
        configureCollectionView()
        
        configureModels()
        
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(slideToNextAdvertisement), userInfo: nil, repeats: true)

    }
    
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
    
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(150)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 7.5, leading: 7.5, bottom: 7.5, trailing: 7.5)
        
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)),
            subitem: item,
            count: 4)
        
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)),
            subitem: horizontalGroup,
            count: 2)
        
        // Section
        let section = NSCollectionLayoutSection(group: verticalGroup)
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    private func configureCollectionView() {
        advertisementCollectionView.delegate = self
        advertisementCollectionView.dataSource = self
        
        advertisementCollectionView.register(HorizontalScrollCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalScrollCollectionViewCell.identifier)
        advertisementCollectionView.backgroundColor = .secondarySystemBackground
        advertisementCollectionView.isScrollEnabled = false
        
        promotionCollectionView.delegate = self
        promotionCollectionView.dataSource = self
        
        promotionCollectionView.register(_2x4CollectionViewCell.self, forCellWithReuseIdentifier: _2x4CollectionViewCell.identifier)
        promotionCollectionView.backgroundColor = .secondarySystemBackground
        promotionCollectionView.isScrollEnabled = false
        
        
        contentView.addSubview(advertisementCollectionView)
        contentView.addSubview(promotionCollectionView)

    }
    
    @objc private func slideToNextAdvertisement() {
        advertisementPageControl.currentPage = currentAdvertisementIndex
        advertisementCollectionView.scrollToItem(at: IndexPath(item: currentAdvertisementIndex, section: 0), at: .right, animated: true)
        if currentAdvertisementIndex <= advertisementPhotos.count - 1 {
            currentAdvertisementIndex += 1
        }
        else {
            currentAdvertisementIndex = 0
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: 89)
        imageView.frame = CGRect(x: 0, y: tableView.bottom, width: contentView.width, height: 90)
        advertisementCollectionView.frame = CGRect(x: 0, y: imageView.bottom, width: contentView.width, height: 200)
        advertisementPageControl.frame = CGRect(x: 0, y: advertisementCollectionView.bottom + 5, width: contentView.width, height: 20)
        couponImageView.frame = CGRect(x: 0, y: advertisementPageControl.bottom + 40, width: contentView.width, height: 20)
        couponLabel.frame = CGRect(x: couponImageView.left + 100, y: couponImageView.top + 5, width: couponImageView.width / 2, height: 10)
        promotionCollectionView.frame = CGRect(x: 0, y: couponImageView.bottom + 20, width: contentView.width, height: 400)
    }
    
    private func configureModels() {
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        
        
        let cell1 = PromotionCollectionViewCellViewModel(title: "0 THB Delivery Fee", imageURL: nil)
        let cell2 = PromotionCollectionViewCellViewModel(title: "ลดสูงสุด 60%", imageURL: nil)
        let cell3 = PromotionCollectionViewCellViewModel(title: "เก็บโค้ดลดเพิ่ม", imageURL: nil)
        let cell4 = PromotionCollectionViewCellViewModel(title: "ชวนเพื่อนใช้  ได้รถได้ทอง!", imageURL: nil)
        let cell5 = PromotionCollectionViewCellViewModel(title: "ส่วนลดลูกค้า AIS", imageURL: nil)
        let cell6 = PromotionCollectionViewCellViewModel(title: "ลดเพิ่ม 50 บาท", imageURL: nil)
        let cell7 = PromotionCollectionViewCellViewModel(title: "ส่วนลดบัตรเครดิต/เดบิต", imageURL: nil)
        let cell8 = PromotionCollectionViewCellViewModel(title: "รวมร้านสตรีทฟู้ดชื่อดัง", imageURL: nil)
        
        promotionCell = [cell1,cell2,cell3,cell4,cell5,cell6,cell7,cell8]
        

        advertisementPageControl.numberOfPages = advertisementPhotos.count
        
        DispatchQueue.main.async {
            self.advertisementCollectionView.reloadData()
            self.promotionCollectionView.reloadData()
        }
    }

    
}



extension OrderFoodViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.advertisementCollectionView {
            let visibleRect = CGRect(origin: advertisementCollectionView.contentOffset, size: advertisementCollectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = advertisementCollectionView.indexPathForItem(at: visiblePoint) {
                if currentAdvertisementIndex <= advertisementPhotos.count - 1 {
                    currentAdvertisementIndex = visibleIndexPath.item
                }
                else {
                    currentAdvertisementIndex = 0
                }
                advertisementPageControl.currentPage = currentAdvertisementIndex
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.advertisementCollectionView {
            return advertisementPhotos.count
        }
        if collectionView == self.promotionCollectionView {
            return promotionCell.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.advertisementCollectionView {
            guard let cell = advertisementCollectionView.dequeueReusableCell(withReuseIdentifier: HorizontalScrollCollectionViewCell.identifier, for: indexPath) as? HorizontalScrollCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        if collectionView == self.promotionCollectionView {
            guard let cell = promotionCollectionView.dequeueReusableCell(withReuseIdentifier: _2x4CollectionViewCell.identifier, for: indexPath) as? _2x4CollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = promotionCell[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.advertisementCollectionView {
            return 1
        }
        if collectionView == self.promotionCollectionView {
            return 1
        }
        return 0
        
    }
    
}

extension OrderFoodViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderLocationTableViewCell.identifier) as? HeaderLocationTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: "บ้าน")
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        }
        return " "
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let vc = LocationSelectViewController()
            vc.title = "เลือกที่อยู่จัดส่ง"
            present(vc, animated: true, completion: nil)
        }
        if indexPath.section == 1 {
            let vc = SearchViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}