//
//  SchedulesDoctorService.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 17/12/21.
//

import Foundation


class SchedulesDoctorService: BaseService {
    
    var doctorId = ""
    let headers: [String : String] = [
        "Content-Type": "application/json"
    ]
    
    func method() -> Network.Method {
        .post
    }
    
    func setUrl() -> URL {
        return URL(string: Route.baseUrl + Route.schedulesDoctor.description)!
    }
    
    func query() -> Network.QueryType {
        .json
    }
    
    func signature() -> Network.SignatureType {
        .emptySignature
    }
    
    func setParameters() -> [String : Any]? {
        ["doctor_id" : doctorId]
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
    
    typealias ResponseType = SchedulesDoctorModel
    
    
}
