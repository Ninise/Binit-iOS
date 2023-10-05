//
//  BinitRoutes.swift
//  Binit
//
//  Created by Nikita on 04.10.2023.
//

import Foundation
import Moya

extension BinitApi {
    
    class func getAllArticles(completion: @escaping (Result<[Article], BError>) -> ()) {
        provider.request(.getAllArticles) { result in
            completion(objectData(of: result))
        }
    }
    
    class func searchProducts(_ query: String, _ offset: Int, _ limit: Int) {
        
    }
    
    class func getQuickSearchSuggestions() {
        
    }
    
    class func getGarbageCategories() {
        
    }
    
    class func getQuizQuestions() {
        
    }
    
    class func makeSuggestion(_ request: SuggestRequest) {
        
    }
    
}
