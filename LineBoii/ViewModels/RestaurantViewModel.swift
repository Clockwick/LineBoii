//
//  RestaurantViewModel.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 14/8/2564 BE.
//

import Foundation


struct RestaurantViewModel {
    let name: String
    let timeDelivery: String
    let deliveryPrice: Int
    let supportedTypes: [SupportType]
    let isOfficial: Bool
    let dailyOpenTime: Date
    let dailyClosedTime: Date
    let isPickUp: Bool
    let distance: Float
    let restaurantImageURL: String?
    let foodCategories: [FoodCategory]?
    
}
