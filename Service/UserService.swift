//
//  UserService.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 13/12/21.
//

import Foundation

class UserService: BaseService {
    
    let url: String = "https://medikuy.herokuapp.com/token_authenticate"
    let headers: [String : String] = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZF91c2VyIjozM30.XInUMgK0Uvn-Fbui96zHoTI_ZMwV2M2zW6sdkdpAPvY",
        "Content-Type": "application/json"
    ]
    
    typealias ResponseType = User
    
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
        return headers
    }
    
    func timeout() -> TimeInterval {
        return 30
    }
    
    func cachePolicy() -> NSURLRequest.CachePolicy {
        return .reloadRevalidatingCacheData
    }
    
    func signature() -> Network.SignatureType {
        return .emptySignature
    }
}
