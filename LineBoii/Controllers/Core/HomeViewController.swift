//
//  HomeViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 25/7/2564 BE.
//

import UIKit


enum HomeSectionType {
    case hotRestaurantPromotion(viewModels: [RestaurantPreviewViewModel])
    case streetFoodRestaurantPromotion(viewModels: [RestaurantPreviewViewModel])

    var title: String {
        switch self {
        case .hotRestaurantPromotion:
            return "รวมดีลร้านดัง ลดสูงสุด 60%"
        case .streetFoodRestaurantPromotion:
            return "สตรีทฟู้ดมีโปรลดสูงสุด 30%"
        }
    }
}

class HomeViewController: UIViewController {
    
    private var timer: Timer?
    
    private var currentAdvertisementIndex = 0
    private var currentDiscountIndex = 0
    
    private var sections = [HomeSectionType]()
    
    private var advertisementPhotos = [String]()
    
    private var discountPhotos = [String]()
    
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
    
    
    // MARK: - CollectionView
    private var cardCollectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _ ) -> NSCollectionLayoutSection? in
            return HomeViewController.createCardSectionLayout(section: sectionIndex)
        })
    )
    
    private var photoCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _ ) -> NSCollectionLayoutSection? in
        return HomeViewController.createAdvertisementPhotosectionLayout(section: sectionIndex)
    }))
    
    private var discountPhotoCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _ ) -> NSCollectionLayoutSection? in
        return HomeViewController.createDiscountPhotosectionLayout(section: sectionIndex)
    }))
    
    // MARK: - PageControl
    
    private let advertismentPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .tertiaryLabel
        pageControl.currentPageIndicatorTintColor = .label

        return pageControl
    }()
    
    
    private let discountPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .tertiaryLabel
        pageControl.currentPageIndicatorTintColor = .label
        return pageControl
    }()
    
    
    // MARK: - Spinner
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - Text
    
    private let helloText: UILabel = {
        let label = UILabel()
        label.text = "สวัสดี"
        label.font = UIFont(name: "supermarket", size: 20)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private let helpText: UILabel = {
        let label = UILabel()
        label.text = "วันนี้มีอะไรให้เราช่วยไหม?"
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "supermarket", size: 24)
        return label
    }()
    
    // MARK: - ImageView
    private let advertisementImageView: UIImageView = {
        let image = UIImage(systemName: "photo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .label
        imageView.tintColor = .secondarySystemBackground
        return imageView
    }()
    
    // MARK: - Button
    
    private let deliveryButton: UIButton = UIButton()
    
    private let bikeIconButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "bicycle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        
        button.backgroundColor = .secondarySystemBackground
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let taxiIconButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "car", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        button.backgroundColor = .secondarySystemBackground
        button.setImage(image, for: .normal)
        button.tintColor = .label
        
        return button
    }()
    
    // MARK: - Label
    
    private let messengerTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Messenger"
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.font = UIFont(name: "supermarket", size: 22)
        
        return label
    }()
    
    private let taxiTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Taxi"
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.font = UIFont(name: "supermarket", size: 22)
        
        return label
    }()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.backgroundColor = .secondarySystemBackground
        
        // Init
        createGradientBackground()
        contentView.addSubview(helloText)
        contentView.addSubview(helpText)
        initButton()
        let bikeElevationIconButton = addButtonElevation(button: bikeIconButton)
        bikeElevationIconButton.layer.masksToBounds = false
        bikeElevationIconButton.layer.cornerRadius = 10
        let taxiElevationIconButton = addButtonElevation(button: taxiIconButton)
        taxiElevationIconButton.layer.masksToBounds = false
        taxiElevationIconButton.layer.cornerRadius = 10
        contentView.addSubview(bikeElevationIconButton)
        contentView.addSubview(taxiElevationIconButton)
        contentView.addSubview(messengerTextLabel)
        contentView.addSubview(taxiTextLabel)
        contentView.addSubview(advertisementImageView)
        contentView.addSubview(advertismentPageControl)
        contentView.addSubview(discountPageControl)
        
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        discountPhotoCollectionView.delegate = self
        discountPhotoCollectionView.dataSource = self
        
        configureCollectionView()
        configurePhotoCollectionView()
        
        configureModels()
        
        configureTargets()
        
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(slideToNextAdvertisement), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(slideToNextDiscount), userInfo: nil, repeats: true)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        helloText.frame = CGRect(x: 10, y: contentView.safeAreaInsets.top + 40 , width: 50, height: 30)
        helpText.frame = CGRect(x: 10, y: helloText.bottom + 10, width: contentView.width / 2, height: 30)
        deliveryButton.frame = CGRect(x: 10, y: helpText.bottom + 10 , width: contentView.width - 20, height: 100)
        let deliveryButtonSize = contentView.width - 20
        let iconButtonSize = (deliveryButtonSize / 2) - 5
        bikeIconButton.frame = CGRect(x: 10, y: deliveryButton.bottom + 10, width: iconButtonSize, height: iconButtonSize / 2)
        taxiIconButton.frame = CGRect(x: bikeIconButton.right + 10, y: deliveryButton.bottom + 10, width: iconButtonSize, height: iconButtonSize / 2)
        
        messengerTextLabel.frame = CGRect(x: bikeIconButton.left, y: bikeIconButton.bottom + 10, width: iconButtonSize, height: 20)
        taxiTextLabel.frame = CGRect(x: taxiIconButton.left, y: taxiIconButton.bottom + 10, width: iconButtonSize, height: 20)
        
        
        advertisementImageView.frame = CGRect(x: 10, y: taxiTextLabel.bottom + 10, width: contentView.width - 20 , height: 200)
        
        photoCollectionView.frame = CGRect(x: 10, y: advertisementImageView.bottom + 10, width: contentView.width - 20, height: 200)
        
        advertismentPageControl.frame = CGRect(x: 0, y: photoCollectionView.bottom + 5, width: contentView.width, height: 20)
        
        cardCollectionView.frame = CGRect(x: 10, y: advertismentPageControl.bottom + 10, width: contentView.width - 20, height: 425)
        
        discountPhotoCollectionView.frame = CGRect(x: 10, y: cardCollectionView.bottom + 10, width: contentView.width - 20, height: 200)
        
        discountPageControl.frame = CGRect(x: 0, y: discountPhotoCollectionView.bottom + 5, width: contentView.width, height: 20)
        
    }
    
    // MARK: - Selector
    
    @objc func didTapDelivery() {
        print("Tap")
        let vc = OrderFoodViewController()
        vc.title = "สั่งอาหาร"
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Configure
    
    private func configureTargets() {
        deliveryButton.addTarget(self, action: #selector(didTapDelivery), for: .touchUpInside)
    }
    
    private func configurePhotoCollectionView() {
        photoCollectionView.register(HorizontalScrollCollectionRoundViewCell.self, forCellWithReuseIdentifier: HorizontalScrollCollectionRoundViewCell.identifier)
        photoCollectionView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoCollectionView)
        
        discountPhotoCollectionView.register(HorizontalScrollCollectionRoundViewCell.self, forCellWithReuseIdentifier: HorizontalScrollCollectionRoundViewCell.identifier)
        discountPhotoCollectionView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(discountPhotoCollectionView)
    }
    
    
    private func configureCollectionView() {
        cardCollectionView.register(HorizontalScrollCardCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalScrollCardCollectionViewCell.identifier)
        cardCollectionView.register(
            TitleHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitleHeaderCollectionReusableView.identifier
        )
        
        cardCollectionView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(cardCollectionView)
    }
    
    private func configureModels() {
        
        let previewRestaurant1 = RestaurantPreviewViewModel(title: "Umm!..Milk", subtitle: "สั่งเลย!")
        let previewRestaurant2 = RestaurantPreviewViewModel(title: "KFC", subtitle: "สั่งเลย!")
        let previewRestaurant3 = RestaurantPreviewViewModel(title: "S&P", subtitle: "สั่งเลย!")
        let previewRestaurant4 = RestaurantPreviewViewModel(title: "Tenjo", subtitle: "สั่งเลย!")
        let previewRestaurant5 = RestaurantPreviewViewModel(title: "Senju", subtitle: "สั่งเลย!")
        let previewRestaurant6 = RestaurantPreviewViewModel(title: "Swensen's", subtitle: "สั่งเลย!")
        let previewRestaurant7 = RestaurantPreviewViewModel(title: "AuntieAnne's", subtitle: "สั่งเลย!")
        let previewRestaurant8 = RestaurantPreviewViewModel(title: "Yoshinoya", subtitle: "สั่งเลย!")

        let previewRestaurantList = [previewRestaurant1,previewRestaurant2,previewRestaurant3,previewRestaurant4,previewRestaurant5,previewRestaurant6,previewRestaurant7,previewRestaurant8]

        sections.append(.hotRestaurantPromotion(viewModels: previewRestaurantList))

        sections.append(.streetFoodRestaurantPromotion(viewModels: previewRestaurantList))
        
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        advertisementPhotos.append("")
        
        discountPhotos.append("")
        discountPhotos.append("")
        discountPhotos.append("")
        discountPhotos.append("")
        discountPhotos.append("")
        discountPhotos.append("")
        discountPhotos.append("")
        discountPhotos.append("")
        discountPhotos.append("")
        
        advertismentPageControl.numberOfPages = advertisementPhotos.count
        discountPageControl.numberOfPages = discountPhotos.count
        
        DispatchQueue.main.async {
            self.cardCollectionView.reloadData()
            self.photoCollectionView.reloadData()
            self.discountPhotoCollectionView.reloadData()
        }
        
    }
    
    
    @objc private func slideToNextAdvertisement() {
        advertismentPageControl.currentPage = currentAdvertisementIndex
        photoCollectionView.scrollToItem(at: IndexPath(item: currentAdvertisementIndex, section: 0), at: .right, animated: true)
        if currentAdvertisementIndex <= advertisementPhotos.count - 1 {
            currentAdvertisementIndex += 1
        }
        else {
            currentAdvertisementIndex = 0
        }
    }
    
    @objc private func slideToNextDiscount() {
        discountPageControl.currentPage = currentDiscountIndex
        discountPhotoCollectionView.scrollToItem(at: IndexPath(item: currentDiscountIndex, section: 0), at: .right, animated: true)
        if currentDiscountIndex <= discountPhotos.count - 1 {
            currentDiscountIndex += 1
        }
        else {
            currentDiscountIndex = 0
        }
    }
    
    // MARK: - Section layout
    
    static func createDiscountPhotosectionLayout(section: Int) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        // Vertical Group in horizontal group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(190)),
            subitem: item,
            count: 1)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
        
    }
    
    static func createAdvertisementPhotosectionLayout(section: Int) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        // Vertical Group in horizontal group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(190)),
            subitem: item,
            count: 1)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
        
    }
    
    static func createCardSectionLayout(section: Int) -> NSCollectionLayoutSection {
        let supplementaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.8),
                    heightDimension: .absolute(30)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 2)
        
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.425), heightDimension: .absolute(175)),
            subitem: item,
            count: 1)
        
        // Section
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = supplementaryViews
        return section
        
       
        
    }
    
    
    // MARK: - Accessories
    
    private func createGradientBackground() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: -60, width: contentView.width, height: view.height * 0.4))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        
        let gradient = CAGradientLayer()
        gradient.frame = imageView.bounds
        gradient.colors = [
            UIColor.init(red: 15/255, green: 171/255, blue: 116/255, alpha: 1).cgColor,
            UIColor.init(red: 85/255, green: 230/255, blue: 179/255, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        imageView.layer.insertSublayer(gradient, at: 0)
        contentView.addSubview(imageView)
    }
    
    private func initButton() {
        
        let imageView = UIImageView()
        // Elevation
        let button = addButtonElevation(button: deliveryButton)
        
        button.backgroundColor = .secondarySystemBackground
        button.titleLabel?.font = UIFont(name: "supermarket", size: 24)
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Delivery", for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 10
        
        guard let image = UIImage(named: "delivery.png") else {
            return
        }
        
        let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 100, height: 100))
        
        imageView.image = resizedImage
        imageView.contentMode = .scaleAspectFill
        
        button.setImage(imageView.image, for: .normal)
        
        contentView.addSubview(button)
    }
    
    private func addButtonElevation(button: UIButton) -> UIButton {
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 2.0
        return button
    }

    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if collectionView == self.photoCollectionView {
            let visibleRect = CGRect(origin: photoCollectionView.contentOffset, size: photoCollectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = photoCollectionView.indexPathForItem(at: visiblePoint) {
                if currentAdvertisementIndex <= advertisementPhotos.count - 1 {
                    currentAdvertisementIndex = visibleIndexPath.item
                }
                else {
                    currentAdvertisementIndex = 0
                }
                advertismentPageControl.currentPage = currentAdvertisementIndex
            }
        }
        
        if collectionView == self.discountPhotoCollectionView {
            let visibleRect = CGRect(origin: discountPhotoCollectionView.contentOffset, size: discountPhotoCollectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = discountPhotoCollectionView.indexPathForItem(at: visiblePoint) {
                if currentDiscountIndex <= discountPhotos.count - 1 {
                    currentDiscountIndex = visibleIndexPath.item
                }
                else {
                    currentDiscountIndex = 0
                }
                discountPageControl.currentPage = currentDiscountIndex
            }
        }
        
        
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.photoCollectionView {
            return advertisementPhotos.count
        }
        if collectionView == self.discountPhotoCollectionView {
            return discountPhotos.count
        }
        if collectionView == self.cardCollectionView {
            let type = sections[section]
            switch type {
            case .hotRestaurantPromotion(viewModels: let viewModels):
                return viewModels.count
            case .streetFoodRestaurantPromotion(viewModels: let viewModels):
                return viewModels.count
            }
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.photoCollectionView {
            guard let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: HorizontalScrollCollectionRoundViewCell.identifier, for: indexPath) as? HorizontalScrollCollectionRoundViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        
        if collectionView == self.discountPhotoCollectionView {
            guard let cell = discountPhotoCollectionView.dequeueReusableCell(withReuseIdentifier: HorizontalScrollCollectionRoundViewCell.identifier, for: indexPath) as? HorizontalScrollCollectionRoundViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }

        if collectionView == self.cardCollectionView {
            let type = sections[indexPath.section]
            switch type {

            case .hotRestaurantPromotion(viewModels: let viewModels):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalScrollCardCollectionViewCell.identifier, for: indexPath) as? HorizontalScrollCardCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let viewModel = viewModels[indexPath.row]

                cell.configure(with: viewModel)
                return cell
            case .streetFoodRestaurantPromotion(viewModels: let viewModels):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalScrollCardCollectionViewCell.identifier, for: indexPath) as? HorizontalScrollCardCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let viewModel = viewModels[indexPath.row]
                cell.configure(with: viewModel)
                return cell
            }
        }
        
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cardCollectionView.deselectItem(at: indexPath, animated: true)
        photoCollectionView.deselectItem(at: indexPath, animated: true)
        discountPhotoCollectionView.deselectItem(at: indexPath, animated: true)
    }
//
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.cardCollectionView {
            return sections.count
        }
        
        if collectionView == self.photoCollectionView {
            return 1
        }
        
        if collectionView == self.discountPhotoCollectionView {
            return 1
        }
        
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == self.cardCollectionView {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier, for: indexPath) as? TitleHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
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


