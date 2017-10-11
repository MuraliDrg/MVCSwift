//
//  NetworkLayer.swift
//  MVCSwift
//
//  Created by Sanginadam, Muralimohan on 11/10/17.
//  Copyright © 2017 DRG. All rights reserved.
//

import UIKit

struct RespondsModel {
    var isSuccess:Bool
    var error:Error?
    var data:AnyObject?
}

enum httpMethodType :String{
    case GET     = "GET"
    case POST    = "POST"
    case PUT     = "PUT"
    case DELETE  = "DELETE"
}

typealias CompletionHandlerType = (RespondsModel) -> Void

protocol NetWorkingMethods {}

extension NetWorkingMethods {
    
    func performRequestWithPath(path:String, httpMethod:httpMethodType, needsAuth:Bool, params:[String:AnyObject]? ,completionHandler:@escaping CompletionHandlerType) {
        
        
        guard let validUrl = URL(string: path) else {
            print("Path is not valid")
            return
        }
        
        var urlRequest:URLRequest = URLRequest(url:validUrl)
        
        urlRequest.httpMethod = httpMethod.rawValue
        
        
        let session:URLSession = URLSession(configuration: .default)
        
        switch httpMethod {
            
        case .GET:
            self.initiatContentDownload(urlSession: session, urlRequest: urlRequest, completionHandler:completionHandler)
            break
        case .POST:
            
            urlRequest = self.formateHeader(urlRequest: urlRequest, params: params)
            self.initiatContentDownload(urlSession: session, urlRequest: urlRequest, completionHandler:completionHandler)
            
            break
            
        case .PUT:
            urlRequest = self.formateHeader(urlRequest: urlRequest, params: params)
            self.initiatContentDownload(urlSession: session, urlRequest: urlRequest, completionHandler:completionHandler)
            break
        case .DELETE:
            urlRequest = self.formateHeader(urlRequest: urlRequest, params: params)
            
            self.initiatContentDownload(urlSession: session, urlRequest: urlRequest, completionHandler:completionHandler)
            break
        }
        
    }
    
    func formateHeader( urlRequest:URLRequest, params:[String:AnyObject]?) -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject:(params ?? []), options: .prettyPrinted)
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest;
    }
    
    func initiatContentDownload(urlSession:URLSession, urlRequest:URLRequest, completionHandler:@escaping CompletionHandlerType) {
        
        let dataTask:URLSessionDataTask =   urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data else {
                print("Error: did not receive data")
                return
            }
            
            let jsonData:Any
            
            do {
                jsonData = try JSONSerialization.jsonObject(with: data, options:[])
                
            }catch  {
                print("error trying to convert data to JSON")
                return
            }
            
            let responseModel:RespondsModel = RespondsModel(isSuccess:true, error:error , data: jsonData as AnyObject)
            
            completionHandler(responseModel)
        }
        
        dataTask.resume()
        
    }
}
