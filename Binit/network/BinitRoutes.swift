//
//  BinitRoutes.swift
//  Binit
//
//  Created by Nikita on 04.10.2023.
//

import Foundation
import Moya

extension BinitApi {
    
    class func getAllArticles(completion: @escaping (Result<[Article], BError>) -> Void) {
        provider.request(.getAllArticles) { result in
            completion(objectData(of: result))
        }
    }
    
    class func searchProducts(_ query: String, _ offset: Int, _ limit: Int, completion: @escaping (Result<[Product], BError>) -> Void) {
        provider.request(.searchProducts(query, offset, limit), completion: { result in
            completion(objectData(of: result))
        })
    }
    
    class func getQuickSearchSuggestions(completion: @escaping (Result<[QuickSearch], BError>) -> Void) {
        provider.request(.getQuickSearchSuggestions) { result in
            completion(objectData(of: result))
        }
    }
    
    class func getGarbageCategories(completion: @escaping (Result<[GarbageCategory], BError>) -> Void) {
        provider.request(.getGarbageCategories) { result in
            completion(objectData(of: result))
        }
    }
    
    class func getQuizQuestions(completion: @escaping (Result<[QuizObject], BError>) -> Void) {
        provider.request(.getQuizQuestions) { result in
            completion(objectData(of: result))
        }
    }
    
    class func makeSuggestion(_ request: SuggestRequest, completion: @escaping (Result<SuggestRequest, BError>) -> Void) {
        provider.request(.makeSuggestion(request)) { result in
            completion(objectData(of: result))
        }
    }
    
}
