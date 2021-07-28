//
//  HomeViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 25/7/2564 BE.
//

import UIKit
import TinyConstraints


enum HomeSectionType {
    case advertisementList(viewModels: [AdvertisementViewModel])
    case hotRestaurantPromotion(viewModels: [RestaurantPreviewViewModel])
    case streetFoodRestaurantPromotion(viewModels: [RestaurantPreviewViewModel])
    case promotionList(viewModels: [PromotionViewModel])

    var title: String {
        switch self {
        case .advertisementList:
            return "Header 1"
        case .hotRestaurantPromotion:
            return "รวมดีลร้านดัง ลดสูงสุด 60%"
        case .streetFoodRestaurantPromotion:
            return "สตรีทฟู้ดมีโปรลดสูงสุด 30%"
        case .promotionList:
            return ""
        }
    }
    
}

class HomeViewController: UIViewController {
    
    private var sections = [HomeSectionType]()
    
    lazy var contentViewSize = CGSize(width: self.view.width, height: self.view.height + 400)
    
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
    
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _ ) -> NSCollectionLayoutSection? in
            return HomeViewController.createSectionLayout(section: sectionIndex)
        }))
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
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
    
    private let deliveryButton: UIButton = UIButton()
    
    private let advertisementImageView: UIImageView = {
        
        let image = UIImage(systemName: "photo")
        
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .label
        imageView.tintColor = .systemBackground
        
        return imageView
    }()
    
    private let advertisementImageView1: UIImageView = {
        
        let image = UIImage(systemName: "photo")
        
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .label
        imageView.tintColor = .systemBackground
        
        return imageView
    }()
    
    private let bikeIconButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "bicycle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        
        button.backgroundColor = .systemBackground
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let messengerTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
//        label.backgroundColor = .green
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
//        label.backgroundColor = .red
        label.text = "Taxi"
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.font = UIFont(name: "supermarket", size: 22)
        
        return label
    }()
    
    private let taxiIconButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "car", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        button.backgroundColor = .systemBackground
        button.setImage(image, for: .normal)
        button.tintColor = .label
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.backgroundColor = .systemBackground
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
        contentView.addSubview(advertisementImageView1)
        configureCollectionView()
        configureModels()
        
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
        
        advertisementImageView.frame = CGRect(x: 10, y: taxiTextLabel.bottom + 10, width: contentView.width - 20 , height: contentView.height * 0.15)
        
        advertisementImageView1.frame = CGRect(x: 10, y: advertisementImageView.bottom + 10, width: contentView.width - 20 , height: contentView.height * 0.15)
        collectionView.frame = CGRect(x: 10, y: advertisementImageView1.bottom + 10, width: contentView.width - 20, height: contentView.bounds.height)
        
    }
    
    private func configureCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(HorizontalScrollCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalScrollCollectionViewCell.identifier)
//        collectionView.register(FeaturedPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier)
//        collectionView.register(RecommendedTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
        collectionView.register(
            TitleHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitleHeaderCollectionReusableView.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        
        contentView.addSubview(collectionView)
    }
    
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
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
        
        switch section {
//        case 0:
//            let item = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                   heightDimension: .fractionalHeight(1.0)
//                )
//            )
//
//            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)),
//                subitem: item,
//                count: 1)
//
//            // Section
//            let section = NSCollectionLayoutSection(group: horizontalGroup)
//            section.orthogonalScrollingBehavior = .none
//            section.boundarySupplementaryItems = supplementaryViews
//            return section
        
        case 1:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)),
                subitem: item,
                count: 1)

            // Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryViews
            return section

//        case 2:
//            let item = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
//                                                   heightDimension: .fractionalHeight(0.8)
//                )
//            )
//            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//
//            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200)),
//                subitem: item,
//                count: 1)
//
//            // Section
//            let section = NSCollectionLayoutSection(group: horizontalGroup)
//            section.orthogonalScrollingBehavior = .continuous
//            section.boundarySupplementaryItems = supplementaryViews
//            return section
//
//        case 3:
//            let item = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
//                                                   heightDimension: .fractionalHeight(0.8)
//                )
//            )
//
//            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//
//            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200)),
//                subitem: item,
//                count: 1)
//
//            // Section
//            let section = NSCollectionLayoutSection(group: horizontalGroup)
//            section.orthogonalScrollingBehavior = .continuous
//            section.boundarySupplementaryItems = supplementaryViews
//            return section
//
//        case 4:
//            let item = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                   heightDimension: .fractionalHeight(1.0)
//                )
//            )
//            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//
//            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)),
//                subitem: item,
//                count: 1)
//
//            // Section
//            let section = NSCollectionLayoutSection(group: horizontalGroup)
//            section.orthogonalScrollingBehavior = .groupPaging
//            section.boundarySupplementaryItems = supplementaryViews
//            return section
            
        default:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // Vertical Group in horizontal group
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200)),
                subitem: item,
                count: 1)
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryViews
            return section
        }
        
        
    }
    
    private func configureModels() {

        //Configure Models
        let advertisement1 = AdvertisementViewModel(imageURL: nil)
        let advertisement2 = AdvertisementViewModel(imageURL: nil)
        let advertisement3 = AdvertisementViewModel(imageURL: nil)
        let advertisement4 = AdvertisementViewModel(imageURL: nil)
        
        let advertisementList = [advertisement1, advertisement2,advertisement3,advertisement4]
        
        sections.append(.advertisementList(viewModels: advertisementList))
        
       
        collectionView.reloadData()
    }
    
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
        
        button.backgroundColor = .systemBackground
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .advertisementList(viewModels: let viewModels):
            return viewModels.count
        case .hotRestaurantPromotion(viewModels: let viewModels):
            return 0
        case .streetFoodRestaurantPromotion(viewModels: let viewModels):
            return 0
        case .promotionList(viewModels: let viewModels):
            return 0
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
//
        switch type {
        case .advertisementList(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalScrollCollectionViewCell.identifier, for: indexPath) as? HorizontalScrollCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
//            cell.configure(with: viewModel)
            return cell
        case .hotRestaurantPromotion(viewModels: let viewModels):
            return UICollectionViewCell()
        case .streetFoodRestaurantPromotion(viewModels: let viewModels):
            return UICollectionViewCell()

        case .promotionList(viewModels: let viewModels):
            return UICollectionViewCell()

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier, for: indexPath) as? TitleHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let section = indexPath.section
        let title = sections[section].title
        header.configure(with: title)
        return header
    }
    
    
    
    
}


