//
//  PrimaryIndusturyApi.swift
//  ClearAsset
//
//  Created by MohammadReza on 1/13/21.
//

import Foundation

typealias GetPrimaryIndusturyServiceCompletionHandlar = (PrimaryData?, Error?) -> Void

protocol GetPrimaryIndustryServiceProtocol {
    func getPrimary(completion: @escaping GetPrimaryIndusturyServiceCompletionHandlar)
}

class PrimaryIndustryApi: BaseSDK {
    let primaryURL = "user/get/primary"
    let jsonDecoder = JSONDecoder()
}

extension PrimaryIndustryApi: GetPrimaryIndustryServiceProtocol {
    func getPrimary(completion: @escaping GetPrimaryIndusturyServiceCompletionHandlar) {
        NetworkingClient.shared.getRequest(getURL(url: primaryURL)) { (data, error) in
            if error == nil {
                do {
                    if let mData = data {
                        let decoded = try self.jsonDecoder.decode(PrimaryData.self, from: mData)
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
