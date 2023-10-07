//
//  BinitRepository.swift
//  Binit
//
//  Created by Nikita on 03.10.2023.
//

import Foundation

struct BinitRepository {
    
    static let shared = BinitRepository()
    
    private init() {}
    
    func getAllArticles(completion: @escaping (Result<[Article], BError>) -> Void) {
        BinitApi.getAllArticles(completion: { result in
            completion(result)
        })
    }
    
    func searchProducts(_ query: String, _ offset: Int, _ limit: Int, completion: @escaping (Result<[Product], BError>) -> Void) {
        BinitApi.searchProducts(query, offset, limit, completion: { result in
            completion(result)
        })
    }
    
    func getQuickSearchSuggestions(completion: @escaping (Result<[QuickSearch], BError>) -> Void) {
        BinitApi.getQuickSearchSuggestions(completion: { result in
            completion(result)
        })
    }
    
    func getGarbageCategories(completion: @escaping (Result<[GarbageCategory], BError>) -> Void) {
        BinitApi.getGarbageCategories(completion: { result in
            completion(result)
        })
    }
    
    func getQuizQuestions(completion: @escaping (Result<[QuizObject], BError>) -> Void) {
        BinitApi.getQuizQuestions(completion: { result in
            completion(result)
        })
    }
    
    func makeSuggestion(_ request: SuggestRequest, completion: @escaping (Result<SuggestRequest, BError>) -> Void) {
        BinitApi.makeSuggestion(request, completion: { result in
            completion(result)
        })
    }
    
}
