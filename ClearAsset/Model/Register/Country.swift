//
//  Country.swift
//  ClearAsset
//
//  Created by MohammadReza on 1/13/21.
//

import Foundation

struct CountryData: Codable {
    let data: AllCountry
}

// MARK: - DataClass
struct AllCountry: Codable {
    let country: [Country]
}

// MARK: - Country
struct Country: Codable {
    let name, code: String
}
