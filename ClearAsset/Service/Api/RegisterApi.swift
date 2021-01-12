//
//  RegisterApi.swift
//  ClearAsset
//
//  Created by Peyk Office on 09/01/2021.
//

import Foundation

typealias RegisterStep1Completion = ([[String : Any]]?, Error?) -> Void
typealias RegisterStep2Completion = (TopLevelDataForStep2?, Error?) -> Void

protocol RegisterStep2Protocol {
    func Register(parameter: Codable, completion: @escaping RegisterStep2Completion)
}

protocol RegisterStep1Protocol {
    func register(parameter: Codable, completion: @escaping RegisterStep1Completion)
}

class RegisterApi: BaseSDK {
    let step1URL = "user/register/validate/step/1"
    let step2URL = "user/register/validate/step/2"
    var decoder = JSONDecoder()
}

extension RegisterApi: RegisterStep1Protocol {
    func register(parameter: Codable, completion: @escaping RegisterStep1Completion) {
        NetworkingClient.shared.executePOSTrequest(getURL(url: step1URL), parameter.dictionary()) { (response, error) in
            if error == nil {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}

extension RegisterApi: RegisterStep2Protocol {
    func Register(parameter: Codable, completion: @escaping RegisterStep2Completion) {
        NetworkingClient.shared.postRequest(getURL(url: step2URL), parameters: parameter.dictionary()) { (data, error) in
            if error == nil {
                completion(nil, nil)
            } else {
                do {
                    if let mData = data {
                        let decoded = try self.decoder.decode(TopLevelDataForStep2.self, from: mData)
                        completion(decoded, error)
                        return
                    }
                } catch {
                    print("Failed to decode JSON")
                    return
                }
            }
        }
    }
}
