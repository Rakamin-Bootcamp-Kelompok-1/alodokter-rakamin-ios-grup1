//
//  HistoryBookingService.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 16/12/21.
//

import Foundation


class HistoryBookingService: BaseService {
    
    var userId = ""
    let headers: [String : String] = [
        "Content-Type": "application/json"
    ]
    
    func method() -> Network.Method {
        return .post
    }
    
    func setUrl() -> URL {
        return URL(string: Route.baseUrl + Route.historyBooking.description)!
    }
    
    func query() -> Network.QueryType {
        .json
    }
    
    func signature() -> Network.SignatureType {
        .emptySignature
    }
    
    func setParameters() -> [String : Any]? {
        ["user_id":"1"]
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
    
    typealias ResponseType = HistoryBookingModel
    
    
}
