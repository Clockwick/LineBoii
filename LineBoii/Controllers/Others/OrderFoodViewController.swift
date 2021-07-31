//
//  OrderFoodViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 30/7/2564 BE.
//

import UIKit

enum OrderFoodSection {
    case favorite(viewModels: [PreviewRestaurantCardViewModel])
    case promotion(viewModels: [PromotionCardViewModel])
    case trend(viewModels: [PreviewRestaurantCardViewModel])
    case brand(viewModels: [BrandBadgeViewModel])
    case latest(viewModels: [PreviewRestaurantCardViewModel])
    case category(viewModels: [PopularCategoryViewModel])
    
    var title: String {
        switch self {
        case .favorite:
            return "ร้านที่คุณน่าจะชอบ"
        case .promotion:
            return "โปรเด็ดต้องโดน"
        case .trend:
            return "ร้านฮิตติดเทรนด์"
        case .brand:
            return "แบรนด์แนะนำ"
        case .latest:
            return "ร้านที่สั่งซื้อล่าสุด"
        case .category:
            return "หมวดหมู่ยอดนิยม"
        }
    }
    
}

class OrderFoodViewController: UIViewController {
    
    private var sections = [OrderFoodSection]()
    
    private var advertisementPhotos = [String]()
    private var promotionCell = [PromotionCollectionViewCellViewModel]()
    private var brands = [BrandBadgeViewModel]()
    
    private var currentAdvertisementIndex = 0
    
    private var couponAmount = 0
    
    lazy var contentViewSize = CGSize(width: self.view.width, height: self.view.height + 2000)
    
    
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
    
    private var foodCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
        return OrderFoodViewController.createFoodSectionLayout(section: sectionIndex)
    }))
    
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
    
    static func createFoodSectionLayout(section: Int) -> NSCollectionLayoutSection {
        let supplementaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(50)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .topLeading
            )
        ]
        
        switch section {
        
        case 3:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.23), heightDimension: .absolute(125)),
                subitem: item,
                count: 1)
            
            // Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = supplementaryViews
            return section
        case 5:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.23), heightDimension: .absolute(175)),
                subitem: item,
                count: 1)
            
            // Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = supplementaryViews
            return section
            
        default:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 2)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.425), heightDimension: .absolute(225)),
                subitem: item,
                count: 1)
            
            // Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = supplementaryViews
            return section
        }
        
        
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
        
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        
        foodCollectionView.register(
            TitleHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitleHeaderCollectionReusableView.identifier
        )
        foodCollectionView.register(HorizontalScrollTitleCardCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalScrollTitleCardCollectionViewCell.identifier)
        foodCollectionView.register(HorizontalRestaurantPromotionCardCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalRestaurantPromotionCardCollectionViewCell.identifier)
        foodCollectionView.register(HorizontalScrollBrandCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalScrollBrandCollectionViewCell.identifier)
        foodCollectionView.register(HorizontalScrollSmallCardCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalScrollSmallCardCollectionViewCell.identifier)
        
        foodCollectionView.backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(advertisementCollectionView)
        contentView.addSubview(promotionCollectionView)
        contentView.addSubview(foodCollectionView)

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
        promotionCollectionView.frame = CGRect(x: 0, y: couponImageView.bottom + 20, width: contentView.width, height: 300)
        foodCollectionView.frame = CGRect(x: 10, y: promotionCollectionView.bottom + 10, width: contentView.width, height: 2000)
        
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
        
        let favoriteCell1 = PreviewRestaurantCardViewModel(title: "รวมร้านสตรีทฟู้ด เวรี่กู๊ด", imageURL: nil)
        let favoriteCell2 = PreviewRestaurantCardViewModel(title: "รวมร้านสตรีทฟู้ด เวรี่กู๊ด", imageURL: nil)
        let favoriteCell3 = PreviewRestaurantCardViewModel(title: "รวมร้านสตรีทฟู้ด เวรี่กู๊ด", imageURL: nil)
        let favoriteCell4 = PreviewRestaurantCardViewModel(title: "รวมร้านสตรีทฟู้ด เวรี่กู๊ด", imageURL: nil)
        let favoriteCell5 = PreviewRestaurantCardViewModel(title: "รวมร้านสตรีทฟู้ด เวรี่กู๊ด", imageURL: nil)
        let favoriteCell6 = PreviewRestaurantCardViewModel(title: "รวมร้านสตรีทฟู้ด เวรี่กู๊ด", imageURL: nil)
        let favoriteCell7 = PreviewRestaurantCardViewModel(title: "รวมร้านสตรีทฟู้ด เวรี่กู๊ด", imageURL: nil)
        let favoriteCell8 = PreviewRestaurantCardViewModel(title: "รวมร้านสตรีทฟู้ด เวรี่กู๊ด", imageURL: nil)
        let favoriteCell9 = PreviewRestaurantCardViewModel(title: "รวมร้านสตรีทฟู้ด เวรี่กู๊ด", imageURL: nil)
        let favoriteCell10 = PreviewRestaurantCardViewModel(title: "รวมร้านสตรีทฟู้ด เวรี่กู๊ด", imageURL: nil)
        let favoriteCell11 = PreviewRestaurantCardViewModel(title: "รวมร้านสตรีทฟู้ด เวรี่กู๊ด", imageURL: nil)
        let favoriteCell12 = PreviewRestaurantCardViewModel(title: "รวมร้านสตรีทฟู้ด เวรี่กู๊ด", imageURL: nil)
        
        let favoriteCells = [favoriteCell1,favoriteCell2,favoriteCell3,favoriteCell4,favoriteCell5,favoriteCell6,favoriteCell7,favoriteCell8,favoriteCell9, favoriteCell10, favoriteCell11, favoriteCell12]
        
        let trueOrFalse: [Bool] = [true, false]
        let badgeType: [BadgeType] = [.free, .discount]
        
        let promotionCell1 = PromotionCardViewModel(title: "แถมฟรี! ข้ามเหนียว + ส้มตำ เมื่อสั่งปิ้งไก่นาปง1ตัว ฟรี!!", restaurantName: "แซ่บปากเซ", realPrice: "295", discountPrice: "245", isFree: trueOrFalse.randomElement()!, badge: badgeType.randomElement()!)
        let promotionCell2 = PromotionCardViewModel(title: "แถมฟรี! ข้ามเหนียว + ส้มตำ เมื่อสั่งปิ้งไก่นาปง1ตัว ฟรี!!", restaurantName: "แซ่บปากเซ", realPrice: "295", discountPrice: "245", isFree: trueOrFalse.randomElement()!, badge: badgeType.randomElement()!)
        let promotionCell3 = PromotionCardViewModel(title: "แถมฟรี! ข้ามเหนียว + ส้มตำ เมื่อสั่งปิ้งไก่นาปง1ตัว ฟรี!!", restaurantName: "แซ่บปากเซ", realPrice: "295", discountPrice: "245", isFree: trueOrFalse.randomElement()!, badge: badgeType.randomElement()!)
        let promotionCell4 = PromotionCardViewModel(title: "แถมฟรี! ข้ามเหนียว + ส้มตำ เมื่อสั่งปิ้งไก่นาปง1ตัว ฟรี!!", restaurantName: "แซ่บปากเซ", realPrice: "295", discountPrice: "245", isFree: trueOrFalse.randomElement()!, badge: badgeType.randomElement()!)
        let promotionCell5 = PromotionCardViewModel(title: "แถมฟรี! ข้ามเหนียว + ส้มตำ เมื่อสั่งปิ้งไก่นาปง1ตัว ฟรี!!", restaurantName: "แซ่บปากเซ", realPrice: "295", discountPrice: "245", isFree: trueOrFalse.randomElement()!, badge: badgeType.randomElement()!)
        let promotionCell6 = PromotionCardViewModel(title: "แถมฟรี! ข้ามเหนียว + ส้มตำ เมื่อสั่งปิ้งไก่นาปง1ตัว ฟรี!!", restaurantName: "แซ่บปากเซ", realPrice: "295", discountPrice: "245", isFree: trueOrFalse.randomElement()!, badge: badgeType.randomElement()!)
        let promotionCell7 = PromotionCardViewModel(title: "แถมฟรี! ข้ามเหนียว + ส้มตำ เมื่อสั่งปิ้งไก่นาปง1ตัว ฟรี!!", restaurantName: "แซ่บปากเซ", realPrice: "295", discountPrice: "245", isFree: trueOrFalse.randomElement()!, badge: badgeType.randomElement()!)
        let promotionCell8 = PromotionCardViewModel(title: "แถมฟรี! ข้ามเหนียว + ส้มตำ เมื่อสั่งปิ้งไก่นาปง1ตัว ฟรี!!", restaurantName: "แซ่บปากเซ", realPrice: "295", discountPrice: "245", isFree: trueOrFalse.randomElement()!, badge: badgeType.randomElement()!)
        
        let promotionCells = [promotionCell1, promotionCell2, promotionCell3, promotionCell4, promotionCell5, promotionCell6, promotionCell7, promotionCell8]
    
        let trendCell1 = PreviewRestaurantCardViewModel(title: "Dakasi เชียงใหม่", imageURL: nil)
        let trendCell2 = PreviewRestaurantCardViewModel(title: "Dakasi เชียงใหม่", imageURL: nil)
        let trendCell3 = PreviewRestaurantCardViewModel(title: "Dakasi เชียงใหม่", imageURL: nil)
        let trendCell4 = PreviewRestaurantCardViewModel(title: "Dakasi เชียงใหม่", imageURL: nil)
        let trendCell5 = PreviewRestaurantCardViewModel(title: "Dakasi เชียงใหม่", imageURL: nil)
        let trendCell6 = PreviewRestaurantCardViewModel(title: "Dakasi เชียงใหม่", imageURL: nil)
        let trendCell7 = PreviewRestaurantCardViewModel(title: "Dakasi เชียงใหม่", imageURL: nil)
        let trendCell8 = PreviewRestaurantCardViewModel(title: "Dakasi เชียงใหม่", imageURL: nil)
        
        
        let trendCells = [trendCell1, trendCell2, trendCell3, trendCell4, trendCell5, trendCell6, trendCell7, trendCell8]
        
        let brandCell1 = BrandBadgeViewModel(title: "KFC", imageURL: nil)
        let brandCell2 = BrandBadgeViewModel(title: "KFC", imageURL: nil)
        let brandCell3 = BrandBadgeViewModel(title: "KFC", imageURL: nil)
        let brandCell4 = BrandBadgeViewModel(title: "KFC", imageURL: nil)
        let brandCell5 = BrandBadgeViewModel(title: "KFC", imageURL: nil)
        let brandCell6 = BrandBadgeViewModel(title: "KFC", imageURL: nil)
        let brandCell7 = BrandBadgeViewModel(title: "KFC", imageURL: nil)
        let brandCell8 = BrandBadgeViewModel(title: "KFC", imageURL: nil)
        
        let brandCells: [BrandBadgeViewModel] = [brandCell1, brandCell2, brandCell3, brandCell4, brandCell5, brandCell6, brandCell7, brandCell8]
        
        let latestCell1 = PreviewRestaurantCardViewModel(title: "ครัวเจ๊หมวย อาหารตามสั่ง", imageURL: nil)
        let latestCell2 = PreviewRestaurantCardViewModel(title: "ครัวเจ๊หมวย อาหารตามสั่ง", imageURL: nil)
        let latestCell3 = PreviewRestaurantCardViewModel(title: "ครัวเจ๊หมวย อาหารตามสั่ง", imageURL: nil)
        
        let latestCells: [PreviewRestaurantCardViewModel] = [latestCell1, latestCell2, latestCell3]
        
        let popularCell1 = PopularCategoryViewModel(title: "อาหารไทย", imageURL: nil)
        let popularCell2 = PopularCategoryViewModel(title: "อาหารอีสาน", imageURL: nil)
        let popularCell3 = PopularCategoryViewModel(title: "อาหารจานเดียว", imageURL: nil)
        let popularCell4 = PopularCategoryViewModel(title: "อาหารญี่ปุ่น", imageURL: nil)
        let popularCell5 = PopularCategoryViewModel(title: "ก่วยเตี๋ยว", imageURL: nil)
        let popularCell6 = PopularCategoryViewModel(title: "ของหวาน", imageURL: nil)
        let popularCell7 = PopularCategoryViewModel(title: "อาหารจีน", imageURL: nil)
        let popularCell8 = PopularCategoryViewModel(title: "อาหารทะเล", imageURL: nil)
        let popularCell9 = PopularCategoryViewModel(title: "สตรีทฟู้ด/รถเข็น", imageURL: nil)
        let popularCell10 = PopularCategoryViewModel(title: "ซูซิ", imageURL: nil)
        let popularCell11 = PopularCategoryViewModel(title: "อาหารตามสั่ง", imageURL: nil)
        let popularCell12 = PopularCategoryViewModel(title: "ข้าวต้ม", imageURL: nil)
        let popularCell13 = PopularCategoryViewModel(title: "ฟาสต์ฟู้ด", imageURL: nil)
        let popularCell14 = PopularCategoryViewModel(title: "อาหารเวียดนาม", imageURL: nil)
        let popularCell15 = PopularCategoryViewModel(title: "อาหารคลีน/สลัด", imageURL: nil)
        let popularCell16 = PopularCategoryViewModel(title: "ชานมไข่มุก", imageURL: nil)
        let popularCell17 = PopularCategoryViewModel(title: "เบเกอรี่ เค้ก", imageURL: nil)
        let popularCell18 = PopularCategoryViewModel(title: "ร้านกาแฟ", imageURL: nil)
        let popularCell19 = PopularCategoryViewModel(title: "อาหารเช้า", imageURL: nil)
        
        let popularCells = [popularCell1,popularCell2,popularCell3,popularCell4,popularCell5,popularCell6,popularCell7,popularCell8,popularCell9,popularCell10,popularCell11,popularCell12,popularCell13,popularCell14,popularCell15,popularCell16,popularCell17,popularCell18,popularCell19]
        
        // Section Append
        sections.append(.favorite(viewModels: favoriteCells))
        sections.append(.promotion(viewModels: promotionCells))
        sections.append(.trend(viewModels: trendCells))
        sections.append(.brand(viewModels: brandCells))
        sections.append(.latest(viewModels: latestCells))
        sections.append(.category(viewModels: popularCells))
        
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
        if collectionView == self.foodCollectionView {
            let type = sections[section]
            switch type {
            case .favorite(viewModels: let viewModels):
                return viewModels.count
            case .promotion(viewModels: let viewModels):
                return viewModels.count
            case .trend(viewModels: let viewModels):
                return viewModels.count
            case .brand(viewModels: let viewModels):
                return viewModels.count
            case .latest(viewModels: let viewModels):
                return viewModels.count
            case .category(viewModels: let viewModels):
                return viewModels.count
            }
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
        if collectionView == self.foodCollectionView {
            let type = sections[indexPath.section]
            switch type {
            case .favorite(viewModels: let viewModels):
                guard let cell = foodCollectionView.dequeueReusableCell(withReuseIdentifier: HorizontalScrollTitleCardCollectionViewCell.identifier, for: indexPath) as? HorizontalScrollTitleCardCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let viewModel = viewModels[indexPath.row]
                cell.configure(with: viewModel)
                return cell
            
            case .promotion(viewModels: let viewModels):
                guard let cell = foodCollectionView.dequeueReusableCell(withReuseIdentifier: HorizontalRestaurantPromotionCardCollectionViewCell.identifier, for: indexPath) as? HorizontalRestaurantPromotionCardCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let viewModel = viewModels[indexPath.row]
                cell.configure(with: viewModel)
                return cell
            case .trend(viewModels: let viewModels):
                guard let cell = foodCollectionView.dequeueReusableCell(withReuseIdentifier: HorizontalScrollTitleCardCollectionViewCell.identifier, for: indexPath) as? HorizontalScrollTitleCardCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let viewModel = viewModels[indexPath.row]
                cell.configure(with: viewModel)
                return cell
            case .brand(viewModels: let viewModels):
                guard let cell = foodCollectionView.dequeueReusableCell(withReuseIdentifier: HorizontalScrollBrandCollectionViewCell.identifier, for: indexPath) as? HorizontalScrollBrandCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let viewModel = viewModels[indexPath.row]
                cell.configure(with: viewModel)
                return cell
            case .latest(viewModels: let viewModels):
                guard let cell = foodCollectionView.dequeueReusableCell(withReuseIdentifier: HorizontalScrollTitleCardCollectionViewCell.identifier, for: indexPath) as? HorizontalScrollTitleCardCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let viewModel = viewModels[indexPath.row]
                cell.configure(with: viewModel)
                return cell
            case .category(viewModels: let viewModels):
                guard let cell = foodCollectionView.dequeueReusableCell(withReuseIdentifier: HorizontalScrollSmallCardCollectionViewCell.identifier, for: indexPath) as? HorizontalScrollSmallCardCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let viewModel = viewModels[indexPath.row]
                cell.configure(with: viewModel)
                return cell
            }
            
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
        if collectionView == self.foodCollectionView {
            return sections.count
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == self.foodCollectionView {
            guard let header = foodCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier, for: indexPath) as? TitleHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
                return UICollectionReusableView()
            }
            let section = indexPath.section
            let title = sections[section].title
            header.configure(with: title)
            return header
        }
        return UICollectionReusableView()
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
