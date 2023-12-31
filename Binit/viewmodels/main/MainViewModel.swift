//
//  MainViewModel.swift
//  Binit
//
//  Created by Nikita on 07.10.2023.
//

import Foundation
import UIKit
import SwiftUI

class MainViewModel: NSObject, ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var toast: String? = nil
    
    // Home screeb
    @Published var quickSearches: [QuickSearch] = []
    @Published var categories: [GarbageCategory] = []
    @Published var articles: [Article] = []
    
    
    @Published var error: BError? = nil
    
    func openUrl(urlStr: String) {
        guard let url = URL(string: urlStr) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func getAllArticles() {
        self.isLoading = true
        BinitRepository.shared.getAllArticles(completion: { result in
            switch result {
            case .success(let response):
                self.articles.removeAll()
                self.articles.append(contentsOf: response)
            case .failure(let error):
                self.error = error
            }
            
            self.isLoading = false
        })
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
        self.isLoading = true
        BinitRepository.shared.getGarbageCategories(completion: { result in
            switch result {
            case .success(let response):
                self.categories.removeAll()
                self.categories.append(contentsOf: response.reversed())
            case .failure(let error):
                self.error = error
            }
            self.isLoading = false
        })
    }
    
    func getQuizQuestions() {
        BinitRepository.shared.getQuizQuestions(completion: { result in
            switch result {
            case .success(let response):
                GameUtils.shared.saveQuizQuestions(questions: response)
            case .failure(let error):
                self.error = error
            }
        })
    }
    
    func makeSuggestion(name: String, type: String, desc: String, location: String, image: UIImage? = nil) {
        self.isLoading = true
        if let image = image {
            FirebaseUtils.shared.uploadImage(image: image, completion: { url in
                let request = SuggestRequest(name: name, type: type, description: "\(desc); URL:\(url ?? "failed_to_get_url")", location: location)
                
                BinitRepository.shared.makeSuggestion(request, completion: { result in
                    switch result {
                    case .success(_):
                        self.toast = LocalizedStringKey("Request_send").stringValue()
                    case .failure(let error):
                        self.error = error
                    }
                    
                    self.isLoading = false
                })
            })
        } else {
            let request = SuggestRequest(name: name, type: type, description: desc, location: location)
            
            BinitRepository.shared.makeSuggestion(request, completion: { result in
                switch result {
                case .success(_):
                    self.toast = LocalizedStringKey("Request_send").stringValue()
                case .failure(let error):
                    self.error = error
                }
                
                self.isLoading = false
            })
        }
        
        
    }
    
}
