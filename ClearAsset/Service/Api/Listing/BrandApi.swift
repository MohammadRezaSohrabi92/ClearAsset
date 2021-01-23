//
//  BrandApi.swift
//  ClearAsset
//
//  Created by Peyk Office on 23/01/2021.
//

import Foundation
import Alamofire

typealias GetBrandListServiceCompletion = (DataBrandList?, Error?) -> Void

protocol GetBrandListServiceProtocol {
    func getBrand(parameter: [String: Any], completion: @escaping GetBrandListServiceCompletion)
}

class BrandApi: BaseSDK {
    let getBrandURL = "listing/get/brands"
    let decoder = JSONDecoder()
}

extension BrandApi: GetBrandListServiceProtocol {
    func getBrand(parameter: [String: Any], completion: @escaping GetBrandListServiceCompletion) {
        let headers : HTTPHeaders = [.accept("application/json"), .authorization(bearerToken: Utility().getToken())]
        NetworkingClient.shared.postRequest(getURL(url: getBrandURL), parameters: parameter, headers: headers) { (data, error) in
            if error == nil {
                do {
                    if let mData = data {
                        let decoded = try self.decoder.decode(DataBrandList.self, from: mData)
                        completion(decoded, nil)
                        return
                    }
                } catch {
                    print("Failed to decode JSON")
                }
            } else {
                completion(nil, error)
                return
            }
        }
    }
}
