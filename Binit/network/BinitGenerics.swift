//
//  BinitGenerics.swift
//  Binit
//
//  Created by Nikita on 04.10.2023.
//

import Foundation
import Moya


// MARK: - Response handling support

struct EmptyResponse: Codable {
    var status: Bool
    var code: Int
    var dmsg: String?
    var umsg: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case code
        case dmsg
        case umsg
    }
}


struct ArrayData<T: Codable>: Codable {
    let status: Bool
    let code: Int?
    let dmsg: String?
    let umsg: String?
    let data: [T]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case code
        case dmsg
        case umsg
        case data
    }
}

struct ObjectData<T: Codable>: Codable {
    let status: Bool
    let code: Int?
    let dmsg: String?
    let umsg: String?
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case status
        case code
        case dmsg
        case umsg
        case data
    }
}

extension BinitApi {
    
    static func emptyData(of result: Result<Moya.Response, MoyaError>) -> Result<EmptyResponse, BError> {
        switch result {
        case .success(let data):
            do {
                let successData = try data.filterSuccessfulStatusCodes()
                let response = try successData.map(EmptyResponse.self)
                
                guard response.status else {
                    return .failure(.serverAnswer(message: response.umsg ?? "Something went wrong"))
                }
                return .success(response)
            } catch {
                return .failure(BError(error: error))
            }
        case .failure(let error):
            return .failure(handleError(error))
        }
    }
    
    static func objectData<T: Codable>(of result: Result<Moya.Response, MoyaError>) -> Result<T, BError> {
        switch result {
        case .success(let data):
            do {
                let successData = try data.filterSuccessfulStatusCodes()
                let response = try successData.map(ObjectData<T>.self)
                
                guard response.status,
                    let data = response.data else {
                        return .failure(.serverAnswer(message: response.umsg ?? "Something went wrong"))
                }
                return .success(data)
            } catch {
                let err = error as! MoyaError
                print(err.errorUserInfo)
                
                return .failure(BError(error: error))
            }
        case .failure(let error):
            return .failure(handleError(error))
        }
    }
    
    static func arrayData<T: Codable>(of result: Result<Moya.Response, MoyaError>) -> Result<[T], BError> {
        switch result {
        case .success(let data):
            do {
                let successData = try data.filterSuccessfulStatusCodes()
                let response = try successData.map(ArrayData<T>.self)
                
                guard response.status,
                    let data = response.data else {
                        return .failure(.serverAnswer(message: response.umsg ?? "Something went wrong"))
                }
                return .success(data)
            } catch {
                let err = error as! MoyaError
                print(err.errorUserInfo)

                return .failure(BError(error: error))
            }
        case .failure(let error):
            return .failure(handleError(error))
        }
    }
    
    static func handleError(_ error: MoyaError) -> BError {
        print(error.errorUserInfo)
        var errorMessage = error.localizedDescription
        if errorMessage == "The Internet connection appears to be offline." ||
            errorMessage == "The request timed out" {
            
            errorMessage = "No Internet Connection"
            return BError(message: errorMessage)
        } else {
            return BError(message: error.localizedDescription)
        }
    }
}

