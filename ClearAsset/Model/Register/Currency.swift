//
//  RegisterStep2.swift
//  ClearAsset
//
//  Created by Peyk Office on 11/01/2021.
//

import Foundation

struct CurrencyValue: Codable {
    var name: String?
    var value: String?
}

struct CurrencyList: Codable {
    var currency: [CurrencyValue]?
}

struct currencyData: Codable {
    var data: CurrencyList
}
