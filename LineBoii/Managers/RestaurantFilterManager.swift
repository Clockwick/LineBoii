//
//  RestaurantFilterManager.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 5/8/2564 BE.
//

import Foundation

enum PriceLevel {
    case nonSelect
    case cheap
    case medium
    case expensive
    case highclass
        
    var title: String {
        switch self {
        case .nonSelect:
            return ""
        case .cheap:
            return "฿"
        case .medium:
            return "฿฿"
        case .expensive:
            return "฿฿฿"
        case .highclass:
            return "฿฿฿฿"
        }
    }
}

class RestaurantFilterManager {
    static let shared = RestaurantFilterManager()
    
    var currentSelectedItems = [Bool]()
    var currentSelectedItemsCount = 0
    
    var isOpen = false
    var isAllowCreditCard = false
    var isPromotion = false
    var isPickable = false
    var priceLevel: PriceLevel = .nonSelect
    var foodType = [FoodType]()
    
    func calculateCurrentSelectedItems() {
        var count = 0
        let priceLevelToBoolean = priceLevel != .nonSelect
        let foodTypeToBoolean = foodType.count != 0
        let booleanArray = [isOpen, isAllowCreditCard, isPromotion, isPickable, priceLevelToBoolean, foodTypeToBoolean]
        for item in booleanArray {
            if item {
                count += 1
            }
        }
        print("Current Selected Items : \(count)")
        currentSelectedItemsCount = count
    }

}
