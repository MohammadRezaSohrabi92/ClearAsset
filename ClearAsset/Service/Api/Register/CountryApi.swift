//
//  CountryAPI.swift
//  ClearAsset
//
//  Created by MohammadReza on 1/13/21.
//

import Foundation

typealias GetCountryServiceCompletionHandlar = (CountryData?, Error?) -> Void

protocol GetCountryServiceProtocol {
    func getCountry(completion: @escaping GetCountryServiceCompletionHandlar)
}

class CountryApi: BaseSDK {
    let getCountryURL = "user/get/country"
    let jsonDecoder = JSONDecoder()
}

extension CountryApi: GetCountryServiceProtocol {
    func getCountry(completion: @escaping GetCountryServiceCompletionHandlar) {
        NetworkingClient.shared.getRequest(getURL(url: getCountryURL)) { (data, error) in
            if error == nil {
                do {
                    if let mData = data {
                        let decoded = try self.jsonDecoder.decode(CountryData.self, from: mData)
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
