//
//  SearchViewModel.swift
//  Binit
//
//  Created by Nikita on 08.10.2023.
//

import Foundation

class SearchViewModel: NSObject, ObservableObject {
    
    @Published var items: [Product] = []
    @Published var quickSearches: [QuickSearch] = []

    @Published var isLoading: Bool = false
    @Published var error: BError? = nil
    
    var prevQuery = ""
    
    var offset: Int = 0
    let limit: Int = 25
    
    var endForThisQuery: Bool = false
    
    func search(query: String) {
        
        Utils.log("search \(query)")
        
        self.isLoading = true
        
        let isSameQuery = prevQuery == query
        
        if (prevQuery != query || query.isEmpty) {
            self.items.removeAll()
            self.offset = 0
            self.endForThisQuery = false
        }
                
        if (query.isEmpty || endForThisQuery) {
            return
        }
        
        self.prevQuery = query
        
        BinitRepository.shared.searchProducts(String(query.trimmingCharacters(in: .whitespacesAndNewlines)), offset, limit, completion: { result in
            switch result {
            case .success(let response):
                self.prevQuery = query
                self.offset = self.offset + 26
                
                self.endForThisQuery = response.count < self.limit
                
                self.items.append(contentsOf: response)
            case .failure(let error):
                self.error = error
            }
            
            self.isLoading = false
        })
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
    
}
