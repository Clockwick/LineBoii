//
//  Restaurant.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 3/8/2564 BE.
//

import Foundation


struct Restaurant {
    let name: String
    let isOfficial: Bool
    let dailyOpenTime: String
    let dailyCloseTime: String
    let isPickUp: Bool
    let distance: Float
    let restaurantImageURL: String
    let foodCategories: [FoodCategory]
    
}

struct FoodCategory {
    
}
