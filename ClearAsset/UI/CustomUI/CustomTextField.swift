//
//  CustomTextField.swift
//  ClearAsset
//
//  Created by Peyk Office on 12/12/2020.
//

import Foundation
import UIKit

class CustomTextField : LeftPadedTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()        
    }
    
    fileprivate func setup() {
        self.backgroundColor = UIColor.appTextfieldBG
        self.font = UIFont(name: Utility.appFont.boldFont, size: 15)
        self.textColor = UIColor.appBlueColor    
        self.cornerRadius = 8
        self.borderColor = UIColor.appBorderColor
        self.borderWidth = 1
    }
    
}
