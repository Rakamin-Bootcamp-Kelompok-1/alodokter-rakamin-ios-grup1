//
//  DummyAlbumsService.swift
//  Alodokter_bootcamp
//
//  Created by Abdul Aziz on 20/11/21.
//

import Foundation

class DummyAlbumsService: BaseService {
    
    var url: String = "https://jsonplaceholder.typicode.com/photos/1"
    
    typealias ResponseType = DummyAlbumsModel
    
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
