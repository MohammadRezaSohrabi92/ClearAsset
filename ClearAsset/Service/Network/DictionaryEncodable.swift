//
//  DictionaryEncodable.swift
//  ClearAsset
//
//  Created by Peyk Office on 09/01/2021.
//

import Foundation

extension Encodable {
    func dictionary() -> [String: Any]? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        guard let json = try? encoder.encode(self),
            let dict = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] else {
                return nil
        }
        return dict
    }
}
