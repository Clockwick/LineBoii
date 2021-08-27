//
//  RestaurantLocationViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 25/8/2564 BE.
//

import UIKit

class RestaurantLocationViewController: UIViewController {
    
    private var viewModel: RestaurantReviewViewModel?

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLevelLabel: UILabel!
    @IBOutlet var mapImageView: UIImageView!
    @IBOutlet var locationHeaderLabel: UILabel!
    @IBOutlet var locationDetailLabel: UILabel!
    @IBOutlet var phoneNumberHeaderLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var availiableHeaderLabel: UILabel!
    @IBOutlet var availiableDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapImageView)
        view.addSubview(nameLabel)
        view.addSubview(priceLevelLabel)
        view.addSubview(locationHeaderLabel)
        view.addSubview(locationDetailLabel)
        view.addSubview(phoneNumberHeaderLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(availiableHeaderLabel)
        view.addSubview(availiableDetail)
        
        guard let viewModel = self.viewModel else {
            return
        }
        
        nameLabel.text = viewModel.restaurantName
        priceLevelLabel.text = viewModel.priceLevel
        locationDetailLabel.text = viewModel.locationDetail
        phoneNumberLabel.text = viewModel.phoneNumber
        availiableDetail.text = viewModel.availiableDetail

    }
    
    func initialize(with viewModel: RestaurantReviewViewModel) {
        self.viewModel = viewModel
    }
    
    
    
   
    
}
