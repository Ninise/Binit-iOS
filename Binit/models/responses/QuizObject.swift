//
//  QuizObject.swift
//  Binit
//
//  Created by Nikita on 06.10.2023.
//

import Foundation

struct QuizObject: Codable {
    let question: String
    let answers: [AnswerObject]
}

struct AnswerObject: Codable, Identifiable {
    let id = UUID()
    let answer: String
    let explanation: String
    let isCorrect: Bool
    
    enum CodingKeys: String, CodingKey {
        case answer
        case explanation
        case isCorrect
    }
}
