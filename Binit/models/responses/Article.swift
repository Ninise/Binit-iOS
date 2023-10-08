//
//  Article.swift
//  Binit
//
//  Created by Nikita on 04.10.2023.
//

import Foundation

struct Article: Codable, Identifiable {
    
    let id: Int
    let title: String
    let image: String
    let type: String
    let image_author: String?
    let short_description: String
    let footer: String?
    let description: String
    let items: [SubCategoryItem]
    
}
