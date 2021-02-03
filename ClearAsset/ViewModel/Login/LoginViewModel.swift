//
//  LoginViewModel.swift
//  ClearAsset
//
//  Created by Peyk Office on 18/01/2021.
//

import Foundation

typealias LoginCompletionHandlar = (GetLoginInfoModel?, ErrorMessageModel?) -> Void

typealias CheckLoginValidityCompletion = ((registerStep1Error?) -> Void)

protocol LoginProtocol {
    func login(byEmail email: String?, password: String?, completion: @escaping LoginCompletionHandlar)
}

class LoginViewModel {
    fileprivate var loginService: LoginServiceProtocol
    
    init(loginService: LoginServiceProtocol = LoginApi()) {
        self.loginService = loginService
    }
}

extension LoginViewModel: LoginProtocol {
    func login(byEmail email: String?, password: String?, completion: @escaping LoginCompletionHandlar) {
        checkValidity(email: email, password: password) { (error) in
            if error != nil {
                completion(nil, ErrorMessageModel(title: "", message: error!.description, code: error!.rawValue))
                return
            } else {
                let parameter = Login(email: email, password: password)
                self.loginService.login(parameter: parameter) { (data, error) in
                    if error == nil {
                        guard let token = data?.data, !token.token.isEmpty else {
                            completion(nil, ErrorMessageModel(title: "", message: "token".getString(), code: nil))
                            return
                        }
                        print("token: \(token)")
                        Utility().saveData(inUserDefulat: token.token, keyOfUserDefault: "token")
                        guard let tokenExpire = data?.data, !token.expiredAt.isEmpty else {
                            completion(nil, ErrorMessageModel(title: "", message: "token".getString(), code: nil))
                            return
                        }
                        Utility().saveData(inUserDefulat: tokenExpire.expiredAt, keyOfUserDefault: "tokenExpire")
                        completion(data?.data, nil)
                        return
                    } else {
                        guard let errorMessage = error?.message, !errorMessage.isEmpty else {
                            completion(nil, ErrorMessageModel(title: "", message: error!.message ?? "", code: nil))
                            return
                        }
                        guard let serverError = error?.data?.errors else {
                            completion(nil, ErrorMessageModel(title: "", message: "unknown".getString(), code: nil))
                            return
                        }
                        if !serverError.email[0].isEmpty {
                            completion(nil, ErrorMessageModel(title: "", message: serverError.email[0], code: nil))
                            return
                        }
                        if !serverError.password[0].isEmpty {
                            completion(nil, ErrorMessageModel(title: "", message: serverError.password[0], code: nil))
                            return
                        }
                        return
                    }
                }
            }
        }
    }
    
    func checkValidity(email: String?, password: String?, completion: @escaping CheckLoginValidityCompletion) {
        if !isEmailValid(email) {
            completion(registerStep1Error.email)
            return
        }
        
        guard let mPassword = password, !mPassword.isEmpty, mPassword.count >= 6 else {
            completion(registerStep1Error.password)
            return
        }
        completion(nil)
        return
    }
    
    fileprivate func isEmailValid(_ email: String?) -> Bool {
        guard let userEmail = email, !userEmail.isEmpty else {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: userEmail)
    }
}
