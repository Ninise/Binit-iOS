//
//  Product.swift
//  Binit
//
//  Created by Nikita on 06.10.2023.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let name: String
    let type: String
    let description: String
    let image: String
}
