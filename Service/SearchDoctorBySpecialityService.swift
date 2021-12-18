//
//  SearchDoctorBySpeciality.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 18/12/21.
//

import Foundation


class SearchDoctorBySpecialityService: BaseService {
    
    var specialityName = ""
    let headers: [String : String] = [
        "Content-Type": "application/json"
    ]
    
    func method() -> Network.Method {
        .post
    }
    
    func setUrl() -> URL {
        return URL(string: Route.baseUrl + Route.doctorBySpeciality.description)!
    }
    
    func query() -> Network.QueryType {
        .json
    }
    
    func signature() -> Network.SignatureType {
        .emptySignature
    }
    
    func setParameters() -> [String : Any]? {
        ["speciality":specialityName]
    }
    
    func setHeaders() -> [String : String] {
        return headers
    }
    
    func timeout() -> TimeInterval {
        return 30
    }
    
    func cachePolicy() -> NSURLRequest.CachePolicy {
        .reloadRevalidatingCacheData
    }
    
    
    typealias ResponseType = DoctorModel
    
    
}
