//
//  Register.swift
//  ClearAsset
//
//  Created by Peyk Office on 09/01/2021.
//

import Foundation

struct RegisterModelStep1 : Codable {
    let email: String?
    let password: String?
    let rePassword: String?
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
        case rePassword = "password_confirmation"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        rePassword = try values.decodeIfPresent(String.self, forKey: .rePassword)
    }
    
    init(email: String?, password: String?, rePassword: String?) {
        self.email = email
        self.password = password
        self.rePassword = rePassword
    }
}


enum registerStep1Error: Int, CustomStringConvertible {
    case email = 1, password, rePassword
    
    var description: String {
        switch self {
        case .email:
            return "Email is not valid"
        case .password:
            return "Password is not valid"
        case .rePassword:
            return "Re-Password is not valid"
        }
    }
}
