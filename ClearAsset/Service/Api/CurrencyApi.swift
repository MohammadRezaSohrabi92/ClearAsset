//
//  Currency.swift
//  ClearAsset
//
//  Created by Peyk Office on 11/01/2021.
//

import Foundation

typealias GetCurrencyCompletion = (currencyData?, Error?) -> Void

protocol GetCurrencyProtocol {
    func getCurrency(completion: @escaping GetCurrencyCompletion)
}

class CurrencyApi: BaseSDK {
    let decoder = JSONDecoder()
    let getCurrencyURL = "user/get/currency"
}

extension CurrencyApi: GetCurrencyProtocol {
    func getCurrency(completion: @escaping GetCurrencyCompletion) {
        NetworkingClient.shared.getRequest(getURL(url: getCurrencyURL)) { (data, error) in
            if error == nil {
                do {
                    if let mData = data {
                        let decoded = try self.decoder.decode(currencyData.self, from: mData)                        
                        completion(decoded, nil)
                        return
                    }
                } catch {
                    print("Failed to decode JSON")
                    return
                }
            } else {
                completion(nil, error)
                return
            }
        }
    }
}
