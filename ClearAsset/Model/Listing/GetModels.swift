//
//  GetModels.swift
//  ClearAsset
//
//  Created by Peyk Office on 30/01/2021.
//

import Foundation

// MARK: - TopLevel
struct DataModels: Codable {
    let data: Models
}

struct Models: Codable {
    let models: [Model]
}

struct Model: Codable {
    let id: Int
    let name: String
}
