//
//  CustomTextField.swift
//  ClearAsset
//
//  Created by Peyk Office on 12/12/2020.
//

import Foundation
import UIKit

class CustomTextField : UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    fileprivate func setup() {
        self.backgroundColor = UIColor.appTextfieldBG
        self.font = UIFont(name: Utility.appFont.semiBold, size: 14)
        self.textColor = UIColor.appBlueColor
        self.cornerRadius = 8
        self.borderColor = UIColor.appBorderColor
        self.borderWidth = 1
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 12, y: bounds.origin.y, width: bounds.width + 15, height: bounds.height)
        
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 12, y: bounds.origin.y, width: bounds.width + 15, height: bounds.height)
    }
    
}
