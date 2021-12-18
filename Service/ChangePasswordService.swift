//
//  ChangePasswordService.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 17/12/21.
//

import Foundation

class ChangePasswordService: BaseService {
    
    let userDefaults = UserDefaults()
    var password: String?
    
    init(password: String) {
        self.password = password
    }
    
    typealias ResponseType = UserModel
    
    func method() -> Network.Method {
        return .post
    }
    
    func setUrl() -> URL {
        let url: String = "https://medikuy.herokuapp.com/user/update/\(userDefaults.value(forKey: "id") ?? "")"
        return URL(string: url)!
    }
    
    func query() -> Network.QueryType {
        return .json
    }
    
    func setParameters() -> [String : Any]? {
        let parameters = ["email": userDefaults.value(forKey: "email"), "password": password]
        return parameters as [String : Any]
    }
    
    func setHeaders() -> [String : String] {
        let headers: [String : String] = [
            "Authorization": "Bearer \(userDefaults.value(forKey: "token") ?? "")",
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
        return .emptySignature
    }
}
