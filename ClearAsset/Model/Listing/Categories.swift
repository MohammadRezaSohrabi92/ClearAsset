//
//  GetCategories.swift
//  ClearAsset
//
//  Created by Peyk Office on 23/01/2021.
//

import Foundation

struct DataCategories: Codable {
    let data: Categories?
}

struct Categories: Codable {
    let categories: [Category]?
}

struct Category: Codable {
    let id: Int?
    let name: String?
    let pic: String?
}
