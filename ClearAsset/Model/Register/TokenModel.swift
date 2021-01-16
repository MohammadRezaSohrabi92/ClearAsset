//
//  Token.swift
//  ClearAsset
//
//  Created by Peyk Office on 16/01/2021.
//

import Foundation

struct TokenModel: Codable {
    let data: Token
}

struct Token: Codable {
    let token, expiredAt: String

    enum CodingKeys: String, CodingKey {
        case token
        case expiredAt = "expired_at"
    }
}
