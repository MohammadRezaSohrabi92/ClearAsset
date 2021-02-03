//
//  CategoryApi.swift
//  ClearAsset
//
//  Created by Peyk Office on 23/01/2021.
//

import Foundation
import Alamofire

typealias GetSubCategoryServiceCompletion = (DataCategories?, Error?) -> Void

protocol GetSubCategoryServiceProtocol {
    func getSubCategory(id: String, completion: @escaping GetSubCategoryServiceCompletion)
}

class SubCategoryApi: BaseSDK {
    let getCategoryURL = "listing/get/categories"    
}

extension SubCategoryApi: GetSubCategoryServiceProtocol {
    func getSubCategory(id: String, completion: @escaping GetSubCategoryServiceCompletion) {
        let headers : HTTPHeaders = [.accept("application/json"), .authorization(bearerToken: Utility().getToken())]
        NetworkingClient.shared.getRequest(makeURL(url: getCategoryURL + "/" + id), headers: headers) { (data, error) in
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



