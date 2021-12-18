//
//  BaseService.swift
//  Alodokter_bootcamp
//
//  Created by Abdul Aziz on 20/11/21.
//

import Foundation
import Alamofire
import SwiftyJSON

enum NetworkResponse:String {
    case success
    case failed = "Network request failed."
}

protocol BaseService {
    associatedtype ResponseType: Codable
    
    func method() -> Network.Method
    func setUrl() -> URL
    func query() -> Network.QueryType
    func signature() -> Network.SignatureType
    func setParameters() -> [String: Any]?
    func setHeaders() -> [String: String]
    func timeout() -> TimeInterval
    func cachePolicy() -> NSURLRequest.CachePolicy
}

enum NetworkResult<T> {
    case success(T)
    case failure(String?, Int = 0)
}

enum NetworkStringResult {
    case success(String?, Int = 0)
    case failure(String?, Int = 0)
}

class Network {
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
    }
    
    public enum QueryType {
        case json, normal
    }
    
    public enum SignatureType {
        case withSignature, emptySignature
    }
    
    @discardableResult
    static func request<T: BaseService>(req: T, completionHandler: @escaping (NetworkResult<T.ResponseType>) -> Void) -> DataRequest? {
        
        let url = req.setUrl()
        let request = prepareRequest(for: url, req: req)
        print("url \(url)")
        return Alamofire.request(request).responseJSON { (response) in
            if let json = response.result.value {
                print("JSON: \(JSON(json)) ")
            }
            
            if let err = response.error {
                completionHandler(NetworkResult.failure(err.localizedDescription))
                return
            }
            
            if let responseCode = response.response {
                if let data = response.data {
                    let decoder = JSONDecoder()
                    do {
                        let object = try decoder.decode(T.ResponseType.self, from: data)
                        completionHandler(NetworkResult.success(object))
                    } catch let error {
                        completionHandler(NetworkResult.failure(error.localizedDescription, responseCode.statusCode))
                    }
                }
            }
        }
    }
    
    @discardableResult
    static func requestWithURL<T: BaseService>(req: T, costumURL: URL, completionHandler: @escaping (NetworkResult<T.ResponseType>) -> Void) -> DataRequest? {
        
        let url = costumURL
        let request = prepareRequest(for: url, req: req)
        
        return Alamofire.request(request).responseJSON { (response) in
            if let json = response.result.value {
                
            }
            
            if let err = response.error {
                completionHandler(NetworkResult.failure(err.localizedDescription))
                return
            }
            
            if let responseCode = response.response {
                if let data = response.data {
                    let decoder = JSONDecoder()
                    do {
                        let object = try decoder.decode(T.ResponseType.self, from: data)
                        completionHandler(NetworkResult.success(object))
                    } catch let error {
                        completionHandler(NetworkResult.failure(error.localizedDescription, responseCode.statusCode))
                    }
                }
            }
        }
    }
    
    @discardableResult
    static func requestNoBody<T: BaseService>(req: T, completionHandler: @escaping (NetworkResult<T.ResponseType>) -> Void) -> DataRequest? {
        
        let url = req.setUrl()
        let request = prepareRequestNoBody(for: url, req: req)
        print("cek url \(url)")
        print("cek req \(request)")
        return Alamofire.request(request).responseJSON { (response) in
            if let json = response.result.value {
                print("JSON: \(JSON(json)) ")
            }
            
            if let err = response.error {
                completionHandler(NetworkResult.failure(err.localizedDescription))
                return
            }
            
            if let responseCode = response.response {
                print("response \(response)")
                if let data = response.data {
                    let decoder = JSONDecoder()
                    do {
                        let object = try decoder.decode(T.ResponseType.self, from: data)
                        completionHandler(NetworkResult.success(object))
                    } catch let error {
                        completionHandler(NetworkResult.failure(error.localizedDescription, responseCode.statusCode))
                    }
                }
            }
        }
    }
    
    @discardableResult
    static func requestParameters<T:BaseService>(req: T, parameters:[String:Any]? = nil, completionHandler: @escaping (NetworkResult<T.ResponseType>) -> Void) -> DataRequest? {
        let url = req.setUrl()
        let request = prepareRequestPostWithParam(for: url, req: req, parameters: parameters)
        print("url request \(request)")
        return Alamofire.request(request).responseJSON { (response) in
            if let json = response.result.value {
                print("JSON: \(JSON(json)) ")
            }
            
            if let err = response.error {
                completionHandler(NetworkResult.failure(err.localizedDescription))
                return
            }
            
            if let responseCode = response.response {
                if let data = response.data {
                    let decoder = JSONDecoder()
                    do {
                        let object = try decoder.decode(T.ResponseType.self, from: data)
                        completionHandler(NetworkResult.success(object))
                    } catch let error {
                        print("=======================")
                        print(error.localizedDescription)
                        completionHandler(NetworkResult.failure(error.localizedDescription, responseCode.statusCode))
                    }
                }
            }
        }
    }
    
    @discardableResult
    static func requestWithURLandBody<T: BaseService>(req: T, costumURL: URL, body: [String: Any], completionHandler: @escaping (NetworkResult<T.ResponseType>) -> Void) -> DataRequest? {
        
        let url = costumURL
        let request = prepareRequestWithCustomBody(for: url, req: req, body: body)
        
        return Alamofire.request(request).responseJSON { (response) in
            if let json = response.result.value {
//                print("JSON: \(JSON(json))")
            }
            
            if let err = response.error {
                completionHandler(NetworkResult.failure(err.localizedDescription))
                return
            }
            
            if let responseCode = response.response {
                if let data = response.data {
                    let decoder = JSONDecoder()
                    do {
                        let object = try decoder.decode(T.ResponseType.self, from: data)
                        completionHandler(NetworkResult.success(object))
                    } catch let error {
                        completionHandler(NetworkResult.failure(error.localizedDescription, responseCode.statusCode))
                    }
                }
            }
        }
    }
    
    
    static func uploadPic<T: BaseService>(req: T, completionHandler: @escaping (NetworkStringResult) -> Void) {
        
        var withName = ""
        var imageData : Data?
        
        let request = prepareRequest(for: req.setUrl(), req: req)
        var headers = request.allHTTPHeaderFields
        headers!["Content-type"] = "multipart/form-data"
        
        if let params = req.setParameters() {
            for key in params.keys {
                if let value = params[key] as? Data {
                    withName = key
                    imageData = value
                }
            }
        }
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData!, withName: withName,fileName: "\(withName).jpg", mimeType: self.getMimeType(data: imageData! as NSData)!)
        },to:req.setUrl(),headers: headers)
        { (result) in
            //completionHandler(result)
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    //print(response.result.value)
                    if let json = response.result.value {
                        print("JSON: \(JSON(json)) ")
                    }
                    
                    if let err = response.error {
                        completionHandler(NetworkStringResult.failure(err.localizedDescription))
                        return
                    }
                    
                    if response.response != nil {
                        if let _ = response.data {
                            //let decoder = JSONDecoder()
                            let jsonResult = JSON(response.result.value as Any)
                            if jsonResult["code"].int == 100{
                                //let object = try decoder.decode(T.ResponseType.self, from: data)
                                completionHandler(NetworkStringResult.success(jsonResult["description"].stringValue))
                            }else{
                                completionHandler(NetworkStringResult.failure(jsonResult["description"].stringValue))
                            }
                        }
                    }
                }
            case .failure(let encodingError):
                completionHandler(NetworkStringResult.failure(encodingError.localizedDescription as String))
            }

            
        }
    }
    
    static func getMimeType(data: NSData) -> String? {
        var c = [UInt32](repeating: 0, count: 1)
        data.getBytes(&c, length: 1)
        switch (c[0]) {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x49, 0x4D:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        case 0x46:
            return "text/plain"
        default:
            return "application/octet-stream"
        }
    }
}

extension Network {
    
    private static func prepareRequest<T: BaseService>(for url: URL, req: T) -> URLRequest {
        
        var request : URLRequest? = nil
        var jsonString: String = ""
        var header = req.setHeaders()
        
        switch req.query() {
        case .json:
            request = URLRequest(url: url, cachePolicy: req.cachePolicy(),
                                 timeoutInterval: req.timeout())
            do {
                let serialization = try JSONSerialization.data(withJSONObject: req.setParameters()!, options: JSONSerialization.WritingOptions(rawValue: 0))
                jsonString = String(data: serialization, encoding: .utf8)!
                request!.httpBody = serialization
                
            } catch {
                assertionFailure("Error : while attemping to serialize the data for preparing httpBody \(error)")
            }
        case .normal:
            request = URLRequest(url: url, cachePolicy: req.cachePolicy(), timeoutInterval: req.timeout())
        }
        request!.allHTTPHeaderFields = header
        request!.httpMethod = req.method().rawValue
        
        return request!
    }
    
    private static func prepareRequestNoBody<T: BaseService>(for url: URL, req: T) -> URLRequest {
        
        var request : URLRequest? = nil
        var jsonString: String = ""
        var header = req.setHeaders()
        
        switch req.query() {
        case .json:
            request = URLRequest(url: url, cachePolicy: req.cachePolicy(),
                                 timeoutInterval: req.timeout())
            do {
                let serialization = try JSONSerialization.data(withJSONObject: req.setParameters()!, options: JSONSerialization.WritingOptions(rawValue: 0))
                jsonString = String(data: serialization, encoding: .utf8)!
                
            } catch {
                assertionFailure("Error : while attemping to serialize the data for preparing httpBody \(error)")
            }
        case .normal:
            request = URLRequest(url: url, cachePolicy: req.cachePolicy(), timeoutInterval: req.timeout())
        }
        request!.allHTTPHeaderFields = header
        request!.httpMethod = req.method().rawValue
        
        return request!
    }
    
    private static func prepareRequestPostWithParam<T:BaseService>(for url: URL,req: T,parameters:[String:Any]? = nil) -> URLRequest {
        let urlString = "\(url)"
        var request : URLRequest? = nil
        var jsonString: String = ""
        switch req.query() {
            
        case .json:
            request = URLRequest(url: url, cachePolicy: req.cachePolicy(), timeoutInterval: req.timeout())
            if let params = parameters {
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map {
                    URLQueryItem(name: $0, value: "\($1)")
                }
                request?.url = urlComponent?.url
            }
            do {
                let serialization = try JSONSerialization.data(withJSONObject: req.setParameters()!, options: JSONSerialization.WritingOptions(rawValue: 0))
                jsonString = String(data: serialization, encoding: .utf8)!
                request!.httpBody = serialization
                
            } catch {
                assertionFailure("Error : while attemping to serialize the data for preparing httpBody \(error)")
            }
        case .normal:
            request = URLRequest(url: url, cachePolicy: req.cachePolicy(), timeoutInterval: req.timeout())
        }
        
        request?.allHTTPHeaderFields = req.setHeaders()
        request?.httpMethod = req.method().rawValue
        return request!
            
    }
    
    private static func prepareRequestWithCustomBody<T: BaseService>(for url: URL, req: T, body: [String: Any]) -> URLRequest {
        
        var request : URLRequest? = nil
        var jsonString: String = ""
        var header = req.setHeaders()
        
        request = URLRequest(url: url, cachePolicy: req.cachePolicy(), timeoutInterval: req.timeout())
            do {
                let serialization = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions(rawValue: 0))
                jsonString = String(data: serialization, encoding: .utf8)!
                request!.httpBody = serialization
                
            } catch {
                assertionFailure("Error : while attemping to serialize the data for preparing httpBody \(error)")
            }
        
        request!.allHTTPHeaderFields = header
        request!.httpMethod = "POST"
        
        return request!
    }
}
