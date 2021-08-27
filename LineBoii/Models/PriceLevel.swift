//
//  PriceLevel.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 26/8/2564 BE.
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
