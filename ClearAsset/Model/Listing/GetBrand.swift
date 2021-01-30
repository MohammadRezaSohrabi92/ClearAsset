//
//  GetBrand.swift
//  ClearAsset
//
//  Created by Peyk Office on 23/01/2021.
//

import Foundation

struct DataBrandList: Codable {
    let data: BrandList
}

struct BrandList: Codable {
    let brands: [Brand]
}

struct Brand: Codable {
    let id: Int
    let name: String
}
