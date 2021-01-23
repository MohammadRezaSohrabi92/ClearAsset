//
//  CategoryApi.swift
//  ClearAsset
//
//  Created by Peyk Office on 23/01/2021.
//

import Foundation
import Alamofire

typealias GetCategoryServiceCompletion = (DataCategories?, Error?) -> Void

protocol GetCategoryServiceProtocol {
    func getCategory(completion: @escaping GetCategoryServiceCompletion)
}

class CategoryApi: BaseSDK {
    let getCategoryURL = "listing/get/categories"
    let decoder = JSONDecoder()
}

extension CategoryApi: GetCategoryServiceProtocol {
    func getCategory(completion: @escaping GetCategoryServiceCompletion) {
        let headers : HTTPHeaders = [.accept("application/json"), .authorization(bearerToken: Utility().getToken())]
        NetworkingClient.shared.getRequest(getURL(url: getCategoryURL), headers: headers) { (data, error) in
            if error == nil {
                do {
                    if let mData = data {
                        let decoded = try self.decoder.decode(DataCategories.self, from: mData)
                        completion(decoded, nil)
                        return
                    }
                } catch {
                    print("Failed to decode json")
                    return
                }                                
            } else {
                completion(nil, error)
                return
            }
        }
    }
}



