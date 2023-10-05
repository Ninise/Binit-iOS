//
//  BError.swift
//  Binit
//
//  Created by Nikita on 04.10.2023.
//

import Foundation
import Moya

enum BError: Error {
    
    case serverAnswer(message: String)
    case unknown(message: String)
    
    
    init(error: Error) {
        guard let err = error as? MoyaError,
            let statusCode = err.response?.statusCode else {
                self = .unknown(message: error.localizedDescription)
                return
        }
        
        switch statusCode {

        default:  self = .unknown(message: err.localizedDescription)
        }
    }
    
    init(message: String) {
        self = .unknown(message: message)
    }
    
    var localizedDescription: String {
        switch self {
        
        case .serverAnswer(let message):
            return message
        case .unknown(let message):
            return message
        
        default:
            return "Something went wrong"
        }
    }
}
