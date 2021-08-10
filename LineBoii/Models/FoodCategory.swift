//
//  FoodType.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 5/8/2564 BE.
//

import Foundation

struct FoodCategory {
    let streetFood: Bool
    let milkTea : Bool
    let japanese : Bool
    let east : Bool
    let thai : Bool
    let sea : Bool
    let breakfast : Bool
    let noodle : Bool
    let dessert : Bool
    let coffee : Bool
    let bakery : Bool
    let alacarte : Bool
    let chinese : Bool
    let oneDish : Bool
    let boiledRice : Bool
    let fastFood : Bool
    let vietnamese : Bool
    let sushi : Bool
    let cleanfood : Bool
    let dimsum : Bool
}


enum FoodCategoryEnum: CaseIterable {
    case streetFood
    case milkTea
    case japanese
    case east
    case thai
    case sea
    case breakfast
    case noodle
    case dessert
    case coffee
    case bakery
    case alacarte
    case chinese
    case oneDish
    case boiledRice
    case fastFood
    case vietnamese
    case sushi
    case cleanfood
    case dimsum
    
    var title: String {
        switch self {
        case .streetFood:
            return "สตรีทฟู้ด/รถเข็น"
        case .milkTea:
            return "ชานมไข่มุก"
        case .japanese:
            return "อาหารญี่ปุ่น"
        case .east:
            return "อาหารอีสาน"
        case .thai:
            return "อาหารไทย"
        case .sea:
            return "อาหารทะเล"
        case .breakfast:
            return "อาหารเช้า"
        case .noodle:
            return "ก๋วยเตี๋ยว"
        case .dessert:
            return "ของหวาน"
        case .coffee:
            return "กาแฟ"
        case .bakery:
            return "เบเกอรี่ เค้ก"
        case .alacarte:
            return "อาหารตามสั่ง"
        case .chinese:
            return "อาหารจีน"
        case .oneDish:
            return "อาหารจานเดียว"
        case .boiledRice:
            return "ข้าวต้ม"
        case .fastFood:
            return "ฟาสต์ฟู้ด"
        case .vietnamese:
            return "อาหารเวียดนาม"
        case .sushi:
            return "ซูซิ"
        case .cleanfood:
            return "อาหารคลีน/สลัด"
        case .dimsum:
            return "ติ่มซำ"
        }
    }
        
    
}
