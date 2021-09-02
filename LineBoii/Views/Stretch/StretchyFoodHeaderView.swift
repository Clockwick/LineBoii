//
//  StretchyFoodHeaderView.swift.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 27/8/2564 BE.
//
import GSKStretchyHeaderView
import SDWebImage

enum GSKMode {
    case normal
    case nav
}

class StretchyFoodHeaderView: GSKStretchyHeaderView {
    
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var viewModel: FoodViewModel?
    
    private var parentVC: StretchyFoodViewController?
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImageView.frame = CGRect(x: 0, y: contentView.safeAreaInsets.top, width: contentView.width, height: contentView.height)
    }
    
    
    // MARK: - Set up
    private func setupViews() {
        if let imageURL = viewModel?.foodImageURL {
            self.backgroundImageView.sd_setImage(with: URL(string: imageURL), completed: nil)
        }
        else {
            self.backgroundImageView.image = UIImage(named: "landscape")!
        }
        
        contentView.addSubview(backgroundImageView)
        
    }
    // MARK: - Initialize (Pass data)
    func initialize(with viewModel: FoodViewModel, vc: StretchyFoodViewController) {
        self.viewModel = viewModel
        self.parentVC = vc
    }
    
    
    override func didChangeStretchFactor(_ stretchFactor: CGFloat) {
        super.didChangeStretchFactor(stretchFactor)
        
        
        if self.contentView.height > self.minimumContentHeight {
            self.parentVC?.title = "สั่งอาหาร"
        }
        else {
            self.parentVC?.title = self.viewModel?.title
        }
        
    }
    
    
    
   
    
    
}
