//
//  SearchDoctor.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 17/12/21.
//

import Foundation

class SearchDoctorService: BaseService {
    
    var doctorName = ""
    let headers: [String : String] = [
        "Content-Type": "application/json"
    ]
    
    func setDoctorName(name: String) {
        self.doctorName = name
    }
    
    func method() -> Network.Method {
        .post
    }
    
    func setUrl() -> URL {
        return URL(string: Route.baseUrl + Route.searchDoctor.description)!
    }
    
    func query() -> Network.QueryType {
        .json
    }
    
    func signature() -> Network.SignatureType {
        .emptySignature
    }
    
    func setParameters() -> [String : Any]? {
        ["doctor_name":self.doctorName]
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
