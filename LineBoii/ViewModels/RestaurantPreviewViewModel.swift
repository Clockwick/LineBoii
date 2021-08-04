//
//  RestaurantPreviewViewModel.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 3/8/2564 BE.
//

import Foundation


enum SupportType {
    case credit
}
struct RestaurantListPreviewViewModel {
    let name: String
    let time: String
    let deliveryPrice: Int
    let subtitle: String?
    let isOfficial: Bool
    let isPickUp: Bool
    let distance: Float
    let restaurantImageURL: URL?
    let supportType: [SupportType]?
}
