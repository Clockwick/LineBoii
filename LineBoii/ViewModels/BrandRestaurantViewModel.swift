//
//  BrandViewModel.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 12/8/2564 BE.
//

import Foundation

struct BrandRestaurantViewModel {
    let brandImageURL: String?
    let isOpen: Bool
    let title: String
    let deliveryPrice: Int
    let time: String
    let isOfficial: Bool
    let distance: Float
    let restaurantImageURL: URL?
    let supportType: [SupportType]?
        
}
