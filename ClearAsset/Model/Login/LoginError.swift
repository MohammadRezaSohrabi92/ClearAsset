//
//  LoginError.swift
//  ClearAsset
//
//  Created by Peyk Office on 18/01/2021.
//

import Foundation

struct DataLoginError: Codable {
    let message: String?
    let data: LoginErrorList?
    
    enum CodingKeys: String, CodingKey {
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(LoginErrorList.self, forKey: .data)
    }
}

struct LoginErrorList: Codable {
    let errors: LoginError?
    
    enum CodingKeys: String, CodingKey {
        case errors
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errors = try values.decodeIfPresent(LoginError.self, forKey: .errors)
    }
}

struct LoginError: Codable {
    let email, password: [String]
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent([String].self, forKey: .email) ?? [""]
        password = try values.decodeIfPresent([String].self, forKey: .password) ?? [""]
    }
}
