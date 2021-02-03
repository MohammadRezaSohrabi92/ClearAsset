//
//  AssetTypeApi.swift
//  ClearAsset
//
//  Created by Peyk Office on 30/01/2021.
//

import Foundation
import Alamofire

typealias GetAssetTypeServiceCompletion = (DataAssettype?, Error?) -> Void

protocol GetAssetTypeServiceProtocol {
    func getAssetTypes(completion: @escaping GetAssetTypeServiceCompletion)
}

class AssetTypeApi: BaseSDK {
    let assetTypeURL = "listing/get/assettype"    
}

extension AssetTypeApi: GetAssetTypeServiceProtocol {
    func getAssetTypes(completion: @escaping GetAssetTypeServiceCompletion) {
        let headers : HTTPHeaders = [.accept("application/json"), .authorization(bearerToken: Utility().getToken())]
        NetworkingClient.shared.getRequest(makeURL(url: assetTypeURL), headers: headers) { (data, error) in
            if error == nil {
                do {
                    if let mData = data {
                        let decoded = try self.decoder.decode(DataAssettype.self, from: mData)
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
