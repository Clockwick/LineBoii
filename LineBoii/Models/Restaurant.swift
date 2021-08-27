//
//  Restaurant.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 3/8/2564 BE.
//

import Foundation


struct Restaurant {
    let name: String
    let timeDelivery: String
    let deliveryPrice: Int
    let announcement: String
    let supportedTypes: [SupportType]
    let isOfficial: Bool
    let dailyOpenTime: Date
    let dailyClosedTime: Date
    let isPickUp: Bool
    let distance: Float
    let restaurantImageURL: String
    let foodCategoriesId: [RestaurantCategory]
    let myScore: Int
    let overrallScore: Int
    let restaurantLocationDetail: String
    let contactPhoneNumber: String
    let reviewRestaurantPhotoURL: [String]
    let priceLevel: PriceLevel
}






