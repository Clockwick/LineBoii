//
//  OrderFoodViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 30/7/2564 BE.
//

import UIKit

class OrderFoodViewController: UIViewController {
    
    private var advertisementPhotos = [String]()
    private var promotionPhotos = [String]()
    
    private var currentAdvertisementIndex = 0
    
    private var couponAmount = 0
    
    private let advertisementPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.tintColor = .secondaryLabel
        pageControl.currentPageIndicatorTintColor = .tertiaryLabel

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
        
        view.backgroundColor = .secondarySystemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    
        view.addSubview(tableView)
        view.addSubview(imageView)
        view.addSubview(advertisementPageControl)
        view.addSubview(couponImageView)
        view.addSubview(couponLabel)
        
        configureCollectionView()
        
        configureModels()
        
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(slideToNextAdvertisement), userInfo: nil, repeats: true)

    }
    
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
    
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(30),
                                               heightDimension: .absolute(30)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)),
            subitem: item,
            count: 4)
        
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(30), heightDimension: .absolute(100)),
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
        
        promotionCollectionView.delegate = self
        promotionCollectionView.dataSource = self
        
        promotionCollectionView.register(_2x4CollectionViewCell.self, forCellWithReuseIdentifier: _2x4CollectionViewCell.identifier)
        
        view.addSubview(advertisementCollectionView)

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
        
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 89)
        imageView.frame = CGRect(x: 0, y: tableView.bottom, width: view.width, height: 90)
        advertisementCollectionView.frame = CGRect(x: 0, y: imageView.bottom, width: view.width, height: 200)
        advertisementPageControl.frame = CGRect(x: 0, y: advertisementCollectionView.bottom + 5, width: view.width, height: 20)
        couponImageView.frame = CGRect(x: 0, y: advertisementPageControl.bottom + 40, width: view.width, height: 20)
        couponLabel.frame = CGRect(x: couponImageView.left + 100, y: couponImageView.top + 5, width: couponImageView.width / 2, height: 10)
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
        
        promotionPhotos.append("")
        promotionPhotos.append("")
        promotionPhotos.append("")
        promotionPhotos.append("")
        promotionPhotos.append("")
        promotionPhotos.append("")
        promotionPhotos.append("")
        promotionPhotos.append("")
        
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
            return 0
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
            return UICollectionViewCell()
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
