//
//  GarbageCategory.swift
//  Binit
//
//  Created by Nikita on 06.10.2023.
//

import Foundation
import SwiftUI

struct GarbageCategory: Codable, Identifiable {
    
    let id: Int
    let title: String
    let image: String
    let type: String
    let image_author: String
    let image_author_url: String
    let display_type: String
    let description: String
    let items: [SubCategoryItem]
    
//    func categoryBinImage() -> String {
//        return Utils.categoryBinImage(type)
//    }
//
//    func categoryColor() -> Color {
//        switch RecycleType.parseValue(type) {
//        case RecycleType.RECYCLE: return MainBlue
//        case RecycleType.GARBAGE: return MainOrange
//        default:
//            return MainGreen
//       }
//    }
}


struct SubCategoryItem: Codable {
    let title: String
    let data: [String]
}
