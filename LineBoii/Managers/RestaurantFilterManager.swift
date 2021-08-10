//
//  RestaurantFilterManager.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 5/8/2564 BE.
//

import Foundation

enum PriceLevel {
    case priceless
    case cheap
    case medium
    case expensive
    case highclass
        
    var title: String {
        switch self {
        case .priceless:
            return "฿"
        case .cheap:
            return "฿฿"
        case .medium:
            return "฿฿฿"
        case .expensive:
            return "฿฿฿฿"
        case .highclass:
            return "฿฿฿฿฿"
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
    var priceLevel: PriceLevel = .priceless
    var priceLevelArray = [PriceLevel]()
    var foodCategory = [FoodCategoryEnum]()
    
    func calculateCurrentSelectedItems() {
        var count = 0
        let priceLevelToBoolean = priceLevelArray.count != 0
        let foodTypeToBoolean = foodCategory.count != 0
        let booleanArray = [isOpen, isAllowCreditCard, isPromotion, isPickable, priceLevelToBoolean, foodTypeToBoolean]
        for item in booleanArray {
            if item {
                count += 1
            }
        }
        if priceLevelToBoolean {
            print("Price level array : \(priceLevelArray)")
        }
        print("Current Selected Items : \(count)")
        currentSelectedItemsCount = count
    }
    
    func pushPriceLevel(priceLevel: PriceLevel) {
        priceLevelArray.append(priceLevel)
    }
    
    func popPriceLevel(priceLevel: PriceLevel) {
        var index = -1
        for (i, item) in priceLevelArray.enumerated() {
            if item == priceLevel {
                index = i
                break
            }
        }
        if index != -1 {
            priceLevelArray.remove(at: index)
        }
        
    }

    func clearPriceLevel() {
        priceLevelArray.removeAll()
    }
}
