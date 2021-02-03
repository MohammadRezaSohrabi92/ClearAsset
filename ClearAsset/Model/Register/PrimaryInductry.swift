//
//  PrimaryInductry.swift
//  ClearAsset
//
//  Created by MohammadReza on 1/13/21.
//

import Foundation

struct PrimaryData: Codable {
    let data: Primary
}

struct Primary: Codable {
    let primary: [String]
}
