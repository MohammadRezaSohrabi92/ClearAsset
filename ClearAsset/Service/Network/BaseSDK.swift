//
//  BaseSDK.swift
//  ClearAsset
//
//  Created by Peyk Office on 09/01/2021.
//

import Foundation
import Alamofire

class BaseSDK {
    
    let baseURLstring = "http://clear-asset.com/api/v1/"
    let decoder = JSONDecoder()
    
    let acceptJson = "application/json"
    let multipartContentType = "multipart/form-data"
    let multipartContentDisposition = "form-data"
    let failedJson = "failedJson".getString()
    
    func makeURL(url: String) -> URL {
        return URL(string: baseURLstring + url)!
    }
    
    func getBearerToken() -> String {
        return Utility().reteriveData(inUserDefulat: "token") as! String
    }
    
    func getHeader() -> HTTPHeaders {
        return [.accept("application/json"), .authorization(bearerToken: getBearerToken())]
    }
    
}
