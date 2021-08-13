//
//  RestaurantPreviewViewModel.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 3/8/2564 BE.
//

import Foundation


enum SupportType {
    case credit
    case deliveryCharge(price: Int?)
    case promotion
    
    var charge: String {
        switch self {
        case .deliveryCharge(price: let price):
            if price != 0 {
                return "ค่าส่ง \(String(price!))฿"
            }
            return "ค่าส่งฟรี"
            
        default:
            break
        }
        return ""
    }
    
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
