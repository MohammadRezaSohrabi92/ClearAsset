//
//  LeftPadedTextField.swift
//  ClearAsset
//
//  Created by Peyk Office on 14/12/2020.
//

import Foundation
import UIKit

class LeftPadedTextField : UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 12, y: bounds.origin.y, width: bounds.width + 15, height: bounds.height)
    }    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 12, y: bounds.origin.y, width: bounds.width + 15, height: bounds.height)
    }
}
