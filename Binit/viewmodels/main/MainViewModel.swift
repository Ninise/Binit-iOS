//
//  MainViewModel.swift
//  Binit
//
//  Created by Nikita on 07.10.2023.
//

import Foundation

class MainViewModel: NSObject, ObservableObject {
    
    // Home screeb
    @Published var quickSearches: [QuickSearch] = []
    @Published var categories: [GarbageCategory] = []
    
    
    @Published var error: BError? = nil
    
    func getAllArticles() {
        
    }
    
    func searchProducts(_ query: String, _ offset: Int, _ limit: Int) {
        
    }
    
    func getQuickSearchSuggestions() {
        BinitRepository.shared.getQuickSearchSuggestions(completion: { result in
            switch result {
            case .success(let response):
                self.quickSearches.removeAll()
                self.quickSearches.append(contentsOf: response)
            case .failure(let error):
                self.error = error
            }
        })
    }
    
    func getGarbageCategories() {
        BinitRepository.shared.getGarbageCategories(completion: { result in
            switch result {
            case .success(let response):
                self.categories.removeAll()
                self.categories.append(contentsOf: response)
            case .failure(let error):
                self.error = error
            }
        })
    }
    
    func getQuizQuestions() {
        
    }
    
    func makeSuggestion(_ request: SuggestRequest) {
        
    }
    
}
