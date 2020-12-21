//
//  String.swift
//  ClearAsset
//
//  Created by Peyk Office on 21/12/2020.
//

import Foundation

extension String {
    func getString() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
