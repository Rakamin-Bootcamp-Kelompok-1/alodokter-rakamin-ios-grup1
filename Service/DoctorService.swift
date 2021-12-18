//
//  DoctorService.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 16/12/21.
//

import Foundation


class DoctorService: BaseService {
    var page = ""
    
    let baseUrl: String = "https://medikuy.herokuapp.com/doctors?page="
    

    let headers: [String : String] = [
        "Content-Type": "application/json"
    ]
    
    func method() -> Network.Method {
        .get
    }
    
    func setUrl() -> URL {
        return URL(string: baseUrl + page)!
    }
    
    func query() -> Network.QueryType {
        .json
    }
    
    func signature() -> Network.SignatureType {
        .emptySignature
    }
    
    func setParameters() -> [String : Any]? {
        [:]
    }
    
    func setHeaders() -> [String : String] {
        return headers
    }
    
    func timeout() -> TimeInterval {
        30
    }
    
    func cachePolicy() -> NSURLRequest.CachePolicy {
        .reloadRevalidatingCacheData
    }
    
    typealias ResponseType = DoctorModel
    
    
}
