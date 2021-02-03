//
//  AssetType.swift
//  ClearAsset
//
//  Created by Peyk Office on 30/01/2021.
//

import Foundation

struct DataAssettype: Codable {
    let data: AssetTypeList
}

struct AssetTypeList: Codable {
    let types: [AssetType]
}

struct AssetType: Codable {
    let id: Int
    let name: String
}
