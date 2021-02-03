//
//  RegisterStep2.swift
//  ClearAsset
//
//  Created by Peyk Office on 12/01/2021.
//

import Foundation

struct RegisterStep2Model: Codable {
    let type, currency, fullName, birthday: String

    enum CodingKeys: String, CodingKey {
        case type, currency
        case fullName = "full_name"
        case birthday
    }
}

struct TopLevelDataForStep2: Codable {
    var data: Step2Errors
}

struct Step2Errors: Codable {
    let errors: RegisterStep2Errors
}

struct RegisterStep2Errors: Codable {
    let type, currency, fullName, birthday : [String]

    enum CodingKeys: String, CodingKey {
        case type, currency
        case fullName = "full_name"
        case birthday
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent([String].self, forKey: .type) ?? [""]
        currency = try values.decodeIfPresent([String].self, forKey: .currency) ?? [""]
        fullName = try values.decodeIfPresent([String].self, forKey: .fullName) ?? [""]
        birthday = try values.decodeIfPresent([String].self, forKey: .birthday) ?? [""]
    }
    
    init(type: [String], currency: [String], fullName: [String], birthday: [String]) {
        self.type = type
        self.currency = currency
        self.fullName = fullName
        self.birthday = birthday
    }
}
