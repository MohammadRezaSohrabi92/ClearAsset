//
//  Section.swift
//  ClearAsset
//
//  Created by Peyk Office on 30/01/2021.
//

import Foundation

struct DataSection: Codable {
    let data: Sections
}

struct Sections: Codable {
    let sections: [Section]
}

struct Section: Codable {
    let id: Int
    let name: String
}
