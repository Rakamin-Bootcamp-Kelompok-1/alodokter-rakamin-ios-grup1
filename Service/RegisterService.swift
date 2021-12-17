//
//  RegisterService.swift
//  Alodokter_bootcamp
//
//  Created by hafied Khalifatul ash.shiddiqi on 17/12/21.
//

import Foundation

class RegisterService: BaseService {
    
    let url: String = "https://medikuy.herokuapp.com/user/add"
    
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
//        ["user_id":"1"]
        ["full_name": "hafied", "password": "hafied123", "email": "hafied@hotmail.com", "gender": "male", "birth_date": "05/04/2000", "phone_number": "0896542671534"]
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
    
    typealias ResponseType = UserModel
    
    
}
