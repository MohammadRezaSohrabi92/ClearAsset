//
//  RegisterApi.swift
//  ClearAsset
//
//  Created by Peyk Office on 09/01/2021.
//

import Foundation

typealias RegisterStep1Completion = ([[String : Any]]?, ErrorStep3?) -> Void
typealias RegisterStep2Completion = (TopLevelDataForStep2?, Error?) -> Void
typealias RegisterStep3Completion = (TokenModel?, ErrorStep3?) -> Void

protocol RegisterStep3Protocol {
    func register(parameter: Codable, completion: @escaping RegisterStep3Completion)
}

protocol RegisterStep2Protocol {
    func Register(parameter: Codable, completion: @escaping RegisterStep2Completion)
}

protocol RegisterStep1Protocol {
    func register(parameter: Codable, completion: @escaping RegisterStep1Completion)
}

class RegisterApi: BaseSDK {
    let step1URL = "user/register/validate/step/1"
    let step2URL = "user/register/validate/step/2"
    let step3URL = "user/register"
    var decoder = JSONDecoder()
}

extension RegisterApi: RegisterStep1Protocol {
    func register(parameter: Codable, completion: @escaping RegisterStep1Completion) {
        NetworkingClient.shared.postRequest(getURL(url: step1URL), parameters: parameter.dictionary()) { (response, error) in
            if error == nil {
                completion(nil, nil)
            } else {
                do {
                    if let mData = response {
                        let decoded = try self.decoder.decode(ErrorStep3.self, from: mData)
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

extension RegisterApi: RegisterStep3Protocol {
    func register(parameter: Codable, completion: @escaping RegisterStep3Completion) {
        NetworkingClient.shared.postRequest(getURL(url: step3URL), parameters: parameter.dictionary()) { (data, error) in
            if error == nil {
                do {
                    if let mData = data {
                        let decoded = try self.decoder.decode(TokenModel.self, from: mData)
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
                        let decoded = try self.decoder.decode(ErrorStep3.self, from: mData)
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
