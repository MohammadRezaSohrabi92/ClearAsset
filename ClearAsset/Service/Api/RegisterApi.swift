//
//  RegisterApi.swift
//  ClearAsset
//
//  Created by Peyk Office on 09/01/2021.
//

import Foundation

typealias RegisterStep1Completion = ([[String : Any]]?, Error?) -> Void

protocol RegisterStep1Protocol {
    func register(parameter: Codable, completion: @escaping RegisterStep1Completion)
}

class RegisterApi: BaseSDK {
    let step1URL = "user/register/validate/step/1"
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
