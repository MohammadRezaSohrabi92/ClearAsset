//
//  SaveImage.swift
//  ClearAsset
//
//  Created by Peyk Office on 31/01/2021.
//

import Foundation

struct DataImage: Codable {
    let data: ImageModel
}

struct ImageModel: Codable {
    let pic: String
}
