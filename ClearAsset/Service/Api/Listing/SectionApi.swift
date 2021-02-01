//
//  SectionApi.swift
//  ClearAsset
//
//  Created by Peyk Office on 30/01/2021.
//

import Foundation
import Alamofire

typealias GetSectionServiceCompletion = (DataSection?, Error?) -> Void

protocol GetSectionServiceProtocol {
    func getSection(completion: @escaping GetSectionServiceCompletion)
}

class SectionApi: BaseSDK {
    let getSectionURL = "listing/get/section"
}

extension SectionApi: GetSectionServiceProtocol {
    func getSection(completion: @escaping GetSectionServiceCompletion) {
        NetworkingClient.shared.getRequest(makeURL(url: getSectionURL), headers: getHeader()) { (data, error) in
            if error == nil {
                do {
                    if let mData = data {
                        let decoded = try self.decoder.decode(DataSection.self, from: mData)
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
