//
//  RegisterStep1ViewModel.swift
//  ClearAsset
//
//  Created by Peyk Office on 10/01/2021.
//

import Foundation

typealias checkValidityCompletionHandlar = ((registerStep1Error?) -> Void)

typealias RegisterServiceStep1CompletionHandler = ([[String : Any]]?, ErrorMessageModel?) -> Void

protocol RegisterServiceStep1Protocol {
    func register(byEmail email: String?, password: String?, rePassword: String?, completion: @escaping RegisterServiceStep1CompletionHandler)
}

class RegisterStep1ViewModel {
    fileprivate var registerService: RegisterStep1Protocol
    
    init(registerService: RegisterStep1Protocol = RegisterApi()) {
        self.registerService = registerService
    }
}

extension RegisterStep1ViewModel: RegisterServiceStep1Protocol {
    func register(byEmail email: String?, password: String?, rePassword: String?, completion: @escaping RegisterServiceStep1CompletionHandler) {
        checkValidity(email: email, password: password, rePassword: rePassword) { (error) in
            if error != nil {
                completion(nil, ErrorMessageModel(title: "", message: error!.description, code: error!.rawValue))
                return
            } else {
                let parameter = RegisterModelStep1.init(email: email, password: password, rePassword: rePassword)
                self.registerService.register(parameter: parameter) { (response, error) in
                    if error == nil {
                        completion(response, nil)
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
                        return
                    }
                }
            }
        }
    }
    
    fileprivate func checkValidity(email: String?, password: String?, rePassword: String?, completion: @escaping checkValidityCompletionHandlar) {
        if !isEmailValid(email) {
            completion(registerStep1Error.email)
            return
        }
        
        guard let mPassword = password, !mPassword.isEmpty, mPassword.count >= 6 else {
            completion(registerStep1Error.password)
            return
        }
        
        guard let mRepassword = rePassword, !mRepassword.isEmpty, mRepassword.count == password?.count, mRepassword.contains(password!) else {
            completion(registerStep1Error.rePassword)
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

