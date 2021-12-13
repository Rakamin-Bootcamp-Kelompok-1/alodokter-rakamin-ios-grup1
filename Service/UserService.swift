//
//  UserService.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 13/12/21.
//

import Foundation

class UserService: BaseService {
    
    var url: String = ""
    
    typealias ResponseType = UserModel
    
    func method() -> Network.Method {
        return .get
    }
    
    func setUrl() -> URL {
        return URL(string: url)!
    }
    
    func query() -> Network.QueryType {
        return .normal
    }
    
    func setParameters() -> [String : Any]? {
        return [:]
    }
    
    func setHeaders() -> [String : String] {
        return Utility().getBaseHeader()
    }
    
    func timeout() -> TimeInterval {
        return 30
    }
    
    func cachePolicy() -> NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
    
    func signature() -> Network.SignatureType {
        return .emptySignature
    }
}
