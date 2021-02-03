//
//  RegisterStep3ViewModel.swift
//  ClearAsset
//
//  Created by Peyk Office on 16/01/2021.
//

import Foundation

typealias RegisterStep3ServiceCompletion = (TokenModel?, ErrorMessageModel?) -> Void
typealias RegisterStep3ErrorsCompletion = (RegisterStep3LocalError?) -> Void

protocol RegisterStep3ServiceProtocol {
    func register(email: String?, password: String?, rePassword: String?, accountType: String?, currency: String?, fullName: String?, birthday: String?, country: String?, mobile: String?, addressOne: String?, addressTwo: String?, city: String?, state: String?, zip: String?, interested: String?, primary: String?, completion: @escaping RegisterStep3ServiceCompletion)
}

class RegisterStep3ViewModel {
    var registerService: RegisterStep3Protocol!
    init(registerService: RegisterStep3Protocol = RegisterApi()) {
        self.registerService = registerService
    }
}

extension RegisterStep3ViewModel: RegisterStep3ServiceProtocol {
    func register(email: String?, password: String?, rePassword: String?, accountType: String?, currency: String?, fullName: String?, birthday: String?, country: String?, mobile: String?, addressOne: String?, addressTwo: String?, city: String?, state: String?, zip: String?, interested: String?, primary: String?, completion: @escaping RegisterStep3ServiceCompletion) {
        
        checkValidity(phoneNumber: mobile, addressOne: addressOne, addressTwo: addressTwo, city: city, state: state, zip: zip) { (error) in
            if error != nil {
                completion(nil, ErrorMessageModel(title: "", message: error!.description, code: error!.rawValue))
                return
            } else {
                let parameter = RegisterStep3(email: email, password: password, rePassword: rePassword, accountType: accountType, currency: currency, fullName: fullName, birthday: birthday, country: country, mobile: mobile, addressOne: addressOne, addressTwo: addressTwo, city: city, state: state, zip: zip, interested: interested, primary: primary)
                self.registerService.register(parameter: parameter) { (tokenModel, error) in
                    if error == nil {
                        guard let token = tokenModel?.data, !token.token.isEmpty else {
                            completion(nil, ErrorMessageModel(title: "", message: "token".getString(), code: nil))
                            return
                        }
                        print("token: \(token)")
                        Utility().saveData(inUserDefulat: token.token, keyOfUserDefault: "token")
                        guard let tokenExpire = tokenModel?.data, !token.expiredAt.isEmpty else {
                            completion(nil, ErrorMessageModel(title: "", message: "token".getString(), code: nil))
                            return
                        }
                        Utility().saveData(inUserDefulat: tokenExpire.expiredAt, keyOfUserDefault: "tokenExpire")
                        completion(tokenModel, nil)                        
                        return
                    } else {
                        guard let serverError = error?.data.errors else {
                            completion(nil, ErrorMessageModel(title: "", message: "unknown".getString(), code: nil))
                            return
                        }
                        if !serverError.email[0].isEmpty {
                            completion(nil, ErrorMessageModel(title: "", message: serverError.email[0], code: nil))
                            return
                        }
                        if !serverError.mobile[0].isEmpty {
                            completion(nil, ErrorMessageModel(title: "", message: serverError.mobile[0], code: nil))
                            return
                        }
                        return
                    }
                }
            }
        }
    }
    
    func checkValidity(phoneNumber: String?, addressOne: String?, addressTwo: String?, city: String?, state: String?, zip: String?, completion: @escaping RegisterStep3ErrorsCompletion) {
        
        guard let phone = phoneNumber, !phone.isEmpty else {
            completion(RegisterStep3LocalError.phoneNumber)
            return
        }
        
        if Utility().validatePhoneNumber(value: phone) {
            completion(RegisterStep3LocalError.phoneNumber)
            return
        }
        
        guard let addressLine1 = addressOne, !addressLine1.isEmpty, addressLine1.count > 3 else {
            completion(RegisterStep3LocalError.addressLine1)
            return
        }
        
        guard let city = city, !city.isEmpty ,city.count > 3 else {
            completion(RegisterStep3LocalError.city)
            return
        }
        
        guard let state = state, !state.isEmpty, state.count > 3 else {
            completion(RegisterStep3LocalError.state)
            return
        }
        
        guard let zip = zip, !zip.isEmpty, zip.count > 3 else{
            completion(RegisterStep3LocalError.zip)
            return
        }
        completion(nil)
        return
    }
}
