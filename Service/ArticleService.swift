//
//  DummyAlbumsService.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/9/21.
//

import Foundation

class ArticleService: BaseService {
    var page = 2
    var url: String = "https://medikuy.herokuapp.com/articles"
    
    
    typealias ResponseType = ArticleData
    
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
