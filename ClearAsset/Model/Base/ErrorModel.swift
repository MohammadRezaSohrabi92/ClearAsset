//
//  ErrorModel.swift
//  ClearAsset
//
//  Created by Peyk Office on 09/01/2021.
//

import Foundation

struct ModelResponse {
    var isSuccess: Bool
    var message: String
}

struct ErrorMessageModel {
    var title: String
    var message: String
    var code: Int!
}
