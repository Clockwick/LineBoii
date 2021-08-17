//
//  Food.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 15/8/2564 BE.
//

import Foundation

struct Food {
    let foodImageURL: String?
    let title: String
    let subtitle: String?
    let foodAdditionId: [FoodAddition]
    let addtionalDetail: String? = ""
    let amount: Int = 1
}
