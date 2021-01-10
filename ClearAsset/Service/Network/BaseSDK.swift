//
//  BaseSDK.swift
//  ClearAsset
//
//  Created by Peyk Office on 09/01/2021.
//

import Foundation

class BaseSDK {
    
    let baseURLstring = "http://clear-asset.com/api/v1/"
    
    func getURL(url: String) -> URL {
        return URL(string: baseURLstring + url)!
    }
    
}
