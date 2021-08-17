//
//  RestaurantCategory.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 15/8/2564 BE.
//

import Foundation

struct RestaurantCategory {
    let id: String
    let header: String
    let foodId: [Food]
}

struct RestaurantCategoryViewModel {
    let id: String
    let header: String
    let foodId: [Food]
    var status: ButtonState = .none
}
