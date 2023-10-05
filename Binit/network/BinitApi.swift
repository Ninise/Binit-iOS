//
//  BinitApi.swift
//  Binit
//
//  Created by Nikita on 03.10.2023.
//

import Foundation
import Moya
import Alamofire
import UIKit

class BinitApi {
    
    static var isConnectedToNetwork: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    private static let networkActivityPlugin = NetworkActivityPlugin { (change, target) in
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = change == .began
        }
    }
    
    private static func JSONResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data
        }
    }
    
    
    static let provider = MoyaProvider<ApiService>(requestClosure: MoyaProvider<ApiService>.requestClosure(), plugins: [
        networkActivityPlugin
    ])
    
}

enum ApiService {
    case getAllArticles
    case searchProducts(_ query: String, _ offset: Int, _ limit: Int)
    case getQuickSearchSuggestions
    case getGarbageCategories
    case getQuizQuestions
    case makeSuggestion(_ request: SuggestRequest)
}

extension ApiService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.binit.pro/")!
    }

    var path: String {
        switch self {
        case .getAllArticles:
            return "articles"
        case .searchProducts:
            return "products"
        case .getQuickSearchSuggestions:
            return "quick_search"
        case .getGarbageCategories:
            return "garbage_categories"
        case .getQuizQuestions:
            return "quiz_questions"
        case .makeSuggestion:
            return "suggested"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .makeSuggestion: return .post
        case .getAllArticles, .searchProducts, .getQuickSearchSuggestions, .getGarbageCategories, .getQuizQuestions: return .get
        }
    }
    
    var sampleData: Data {
        return "No sample data available".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
            
        case .searchProducts(let query, let offset, let limit):
            return .requestParameters(parameters: ["query": query, "offset": offset, "limit": limit], encoding: URLEncoding.queryString)
            
        case .makeSuggestion(let request):
            return .requestJSONEncodable(request)
            
        default:
            return .requestPlain
            
        }
    }
    
    var headers: [String : String]? {
        return ["client-type": "iOS"]
    }
    
}

extension MoyaProvider {
    static var provider: MoyaProvider<ApiService> {
        return MoyaProvider<ApiService>()
    }
    
    static func requestClosure() -> MoyaProvider<Target>.RequestClosure {
        return { endpoint, closure in
            let request = try! endpoint.urlRequest()
            
        }
    }
}

