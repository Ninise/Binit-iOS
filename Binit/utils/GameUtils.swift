//
//  GameUtils.swift
//  Binit
//
//  Created by Nikita on 09.10.2023.
//

import Foundation
import SwiftUI

class GameUtils {
    
    static let shared = GameUtils()
    
    private let LAST_QUESTION_INDEX = "LAST_QUESTION_INDEX"
    
    private var questionsList: [QuizObject] = []
    
    private init() {
        
    }
    
    func getBatchOfQuestions() -> [QuizObject] {
        let totalAmount = questionsList.count
        let lastIndex = getData(type: LAST_QUESTION_INDEX)
        
        if (lastIndex + 5 < totalAmount) {
            saveData(index: lastIndex + 4, type: LAST_QUESTION_INDEX)
            var list: [QuizObject] = []
            list.append(contentsOf: questionsList[lastIndex...lastIndex + 4])
            return list
        } else {
            saveData(index: 0, type: LAST_QUESTION_INDEX)
            
            questionsList.shuffle()
            
            var list: [QuizObject] = []
            list.append(contentsOf: questionsList[0...3])
            
            return list
        }
    }
    
    func saveQuizQuestions(questions: [QuizObject]) {
        questionsList.append(contentsOf: questions)
    }
    
    func getData(type: String) -> Int {
        return UserDefaults.standard.integer(forKey: type)
    }
    
    func saveData(index: Int, type: String) {
        UserDefaults.standard.set(index, forKey: type)
    }
 
    
    func getCongratsTextBasedOnScore(score: Int) -> String {
        switch(score) {
        case 1: return LocalizedStringKey("Congrats_1_title").stringValue()
        case 2: return LocalizedStringKey("Congrats_2_title").stringValue()
        case 3: return LocalizedStringKey("Congrats_3_title").stringValue()
        case 4: return LocalizedStringKey("Congrats_4_title").stringValue()
        case 5: return LocalizedStringKey("Congrats_5_title").stringValue()
        default: return LocalizedStringKey("Congrats_1_title").stringValue()
        }
    }

    func getCongratsSubsTextBasedOnScore(score: Int) -> String {
        switch(score) {
        case 1: return LocalizedStringKey("Congrats_3_sub").stringValue()
        case 2: return LocalizedStringKey("Congrats_3_sub").stringValue()
        case 3: return LocalizedStringKey("Congrats_3_sub").stringValue()
        case 4: return LocalizedStringKey("Congrats_4_sub").stringValue()
        case 5: return LocalizedStringKey("Congrats_4_sub").stringValue()
        default: return LocalizedStringKey("Congrats_4_sub").stringValue()
        }
    }
}
