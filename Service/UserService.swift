//
//  UserService.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 13/12/21.
//

import Foundation

class UserService: BaseService {
    
    let userDefaults = UserDefaults()
    let url: String = "https://medikuy.herokuapp.com/token_authenticate"
    var token: String = ""
    
   
    
    func method() -> Network.Method {
        return .get
    }
    
    func setUrl() -> URL {
        return URL(string: url)!
    }
    
    func query() -> Network.QueryType {
        return .json
    }
    
    func setParameters() -> [String : Any]? {
        return [:]
    }
    
    func setHeaders() -> [String : String] {
        let headers: [String : String] = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    func timeout() -> TimeInterval {
        return 30
    }
    
    func cachePolicy() -> NSURLRequest.CachePolicy {
        return .reloadRevalidatingCacheData
    }
    
    func signature() -> Network.SignatureType {
        return .withSignature
    }
    
    typealias ResponseType = UserModel
}
