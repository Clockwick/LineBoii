//
//  RestaurantFilterManager.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 5/8/2564 BE.
//

import Foundation


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
    var foodCategoryArray = [FoodCategoryEnum]()
    
    func calculateCurrentSelectedItems() {
        var count = 0
        let priceLevelToBoolean = priceLevelArray.count != 0
        let foodTypeToBoolean = foodCategoryArray.count != 0
        let booleanArray = [isOpen, isAllowCreditCard, isPromotion, isPickable, priceLevelToBoolean, foodTypeToBoolean]
        for item in booleanArray {
            if item {
                count += 1
            }
        }
        if priceLevelToBoolean {
            print("Price level array : \(priceLevelArray)")
        }
        if foodTypeToBoolean {
            print("Food category array : \(foodCategoryArray)")
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
    
    func pushFoodCategory(foodCategory: FoodCategoryEnum) {
        self.foodCategoryArray.append(foodCategory)
    }
    
    func popFoodCategory(foodCategory: FoodCategoryEnum) {
        var index = -1
        for (i, item) in self.foodCategoryArray.enumerated() {
            if item == foodCategory {
                index = i
                break
            }
        }
        if index != -1 {
            self.foodCategoryArray.remove(at: index)
        }
        
    }

    func clearFoodCategory() {
        self.foodCategoryArray.removeAll()
    }
    
    func getStatus(from foodCategory: FoodCategoryEnum) -> ButtonState {
        for i in foodCategoryArray {
            if foodCategory == i {
                return .active
            }
        }
        return .none
    }
}
