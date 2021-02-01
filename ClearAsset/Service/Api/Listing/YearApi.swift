//
//  YearApi.swift
//  ClearAsset
//
//  Created by Peyk Office on 31/01/2021.
//

import Foundation

typealias GetYearServiceCompletion = (DataYear?, Error?) -> Void

protocol GetYearServiceProtocol {
    func getStartYear(completion: @escaping GetYearServiceCompletion)
}

class YearApi: BaseSDK {
    let getStartYearURL = "listing/get/startyear"    
}

extension YearApi: GetYearServiceProtocol {
    func getStartYear(completion: @escaping GetYearServiceCompletion) {
        NetworkingClient.shared.getRequest(makeURL(url: getStartYearURL), headers: getHeader()) { (data, error) in
            if error == nil {
                do {
                    if let data = data {
                        let decoded = try self.decoder.decode(DataYear.self, from: data)
                        completion(decoded, nil)
                        return
                    }
                } catch {
                    print("Failed to decode JSON - year")
                }
            } else {
                completion(nil, error)
                return
            }
        }
    }
}
