//
//  SuggestRequest.swift
//  Binit
//
//  Created by Nikita on 04.10.2023.
//

import Foundation

struct SuggestRequest: Codable {
    let name: String
    let type: String
    let description: String
    let location: String
}

