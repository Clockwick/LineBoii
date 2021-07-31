//
//  PromotionCardViewModel.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 31/7/2564 BE.
//

import Foundation

struct PromotionCardViewModel {
    let title: String
    let restaurantName: String
    let realPrice: String
    let discountPrice: String
    let isFree: Bool
    let badge: BadgeType
}


enum BadgeType {
    case free
    case discount
    
    var title: String {
        switch self {
        case .free:
            return "แถมฟรี"
        case .discount:
            return "ลดพิเศษ"
        }
    }
}
