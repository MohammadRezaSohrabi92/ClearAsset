//
//  LoginApi.swift
//  ClearAsset
//
//  Created by Peyk Office on 18/01/2021.
//

import Foundation

typealias LoginServiceCompletionHandlar = (DataGetLoginInfoModel?, DataLoginError?) -> Void

protocol LoginServiceProtocol {
    func login(parameter: Codable, completion: @escaping LoginServiceCompletionHandlar)
}

class LoginApi: BaseSDK {
    let loginURL = "user/login"
}

extension LoginApi: LoginServiceProtocol {
    func login(parameter: Codable, completion: @escaping LoginServiceCompletionHandlar) {
        NetworkingClient.shared.postRequest(makeURL(url: loginURL), parameters: parameter.dictionary()) { (data, error) in
            if error == nil {
                do {
                    if let mData = data {
                        let decoded = try self.decoder.decode(DataGetLoginInfoModel.self, from: mData)
                        completion(decoded, nil)
                        return
                    }
                } catch {
                    print("Faild to decode JSON")
                    return
                }
            } else {
                do {
                    if let mData = data {
                        let decoded = try self.decoder.decode(DataLoginError.self, from: mData)
                        completion(nil, decoded)
                        return
                    }
                } catch {
                    print("Faild to decode JSON")
                    return
                }
            }
        }
    }
}
