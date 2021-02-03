//
//  ModelApi.swift
//  ClearAsset
//
//  Created by Peyk Office on 30/01/2021.
//

import Foundation
import Alamofire

typealias GetModelsServiceCompletion = (DataModels?, Error?) -> Void

protocol GetModelServiceProtocol {
    func getModel(parameter: [String: Any], completion: @escaping GetModelsServiceCompletion)
}

class ModelApi: BaseSDK {
    let getModelURL = "listing/get/models"
}

extension ModelApi: GetModelServiceProtocol {
    func getModel(parameter: [String: Any], completion: @escaping GetModelsServiceCompletion) {
        let headers : HTTPHeaders = [.accept("application/json"), .authorization(bearerToken: Utility().getToken())]
        NetworkingClient.shared.postRequest(makeURL(url: getModelURL), parameters: parameter, headers: headers) { (data, error) in
            if error == nil {
                do {
                    if let mData = data {
                        let decoded = try self.decoder.decode(DataModels.self, from: mData)
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
