//
//  GameUtils.swift
//  Binit
//
//  Created by Nikita on 09.10.2023.
//

import Foundation
import SwiftUI

struct GameObject {
    let image: String
    let type: String
    
    init(_ image: String,_ type: String) {
        self.image = image
        self.type = type
    }
}

class GameUtils {
    
    static let shared = GameUtils()
    
    private let LAST_QUESTION_INDEX = "LAST_QUESTION_INDEX"
    private let LAST_GAME_INDEX = "LAST_GAME_INDEX"
    
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
    
    /*
     Drag and drop game
     */
    
    
    private var gameSet = [
        GameObject(
            "ic_game_item_credit_card_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_shopping_bags_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_pencil_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_pen_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_clothes_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_balloon_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_sponge_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_reuse_bug_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_receipt_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_label_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_key_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_wood_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_toothbrush_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_soap_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_paintbrush_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_optical_disk_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_bolt_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_thread_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_razor_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_cigarette_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_styrofoam_box_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_tube_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_hair_brush_barg",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_corks_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_broken_glass_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_chip_bag_rec",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_facemusk_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_candle_garb",
            GarbageUtils.GARBAGE_TYPE),
        GameObject(
            "ic_game_item_egg_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_fish_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_peanuts_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_bread_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_banana_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_lemon_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_kiwi_fruit_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_vegetable_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_bagel_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_orange_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_meat_on_bone_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_pizza_2_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_coffee_beans_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_diaper_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_tea_bug_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_coffee_filter_org",
            GarbageUtils.ORGANIC_TYPE),
        GameObject(
            "ic_game_item_lotion_bottle_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_toilet_towel_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_glass_bottle_2_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_canned_food_3_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_can_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_tissue_box_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_pizza_box_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_water_bottle_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_yogurt_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_takeout_box_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_lotion_bottle_2_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_plastic_cup_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_canned_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_baby_bottle_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_package_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_toilet_paper_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_newspaper_rec",
            GarbageUtils.RECYCLE_TYPE),
        GameObject(
            "ic_game_item_champain_bottle_rec",
            GarbageUtils.RECYCLE_TYPE)
    ]
    
    func getBatchOfItems() -> [GameObject] {
        
        let totalAmount = gameSet.count
                
        let lastIndex = getData(type: LAST_GAME_INDEX)
                
        if (lastIndex == 0) {
            gameSet.shuffle()
        }
        
        if (lastIndex + 10 < totalAmount) {
            saveData(index: lastIndex + 10, type: LAST_GAME_INDEX)
            
            var list: [GameObject] = []
            list.append(contentsOf: gameSet[lastIndex...lastIndex + 9])
                        
            return list
        } else {
            saveData(index: 0, type: LAST_GAME_INDEX)
            
            gameSet.shuffle()
            
            var list: [GameObject] = []
            list.append(contentsOf: gameSet[0...9])
                        
            return list
        }
        
    }
}
