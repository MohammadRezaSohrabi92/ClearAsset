//
//  RegisterStep2ViewModel.swift
//  ClearAsset
//
//  Created by Peyk Office on 11/01/2021.
//

import Foundation

typealias Step2ValidationCompletion = (TopLevelDataForStep2?,ErrorMessageModel?) -> Void

protocol RegisterServiceStep2Protocol {
    func register(accountType: String?, preferredCurrency: String?, fullName: String?, Birthday: String?, completion: @escaping Step2ValidationCompletion)
}

class RegisterStep2ViewModel {
    
    var registerStep2Service: RegisterStep2Protocol!
    
    init(registerStep2Service: RegisterStep2Protocol = RegisterApi()) {
        self.registerStep2Service = registerStep2Service
    }
    
}

extension RegisterStep2ViewModel: RegisterServiceStep2Protocol {
    func register(accountType: String?, preferredCurrency: String?, fullName: String?, Birthday: String?, completion: @escaping Step2ValidationCompletion) {
        guard let name = fullName, !name.isEmpty else {
            completion(nil, ErrorMessageModel(title: "", message: "fullName".getString(), code: nil))
            return
        }
        let parameter = RegisterStep2Model.init(type: accountType ?? "", currency: preferredCurrency ?? "", fullName: fullName ?? "", birthday: Birthday ?? "")
        registerStep2Service.Register(parameter: parameter) { (topLevelError, error) in
            if error == nil {
                completion(nil, nil)
            } else {                
                completion(topLevelError, ErrorMessageModel(title: "", message: (topLevelError?.data.errors.fullName.description)!, code: nil))
            }
        }
    }
}
