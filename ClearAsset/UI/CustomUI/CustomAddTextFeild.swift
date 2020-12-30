//
//  CustomAddTextFeild.swift
//  ClearAsset
//
//  Created by Peyk Office on 27/12/2020.
//

import Foundation
import UIKit

class CustomAddTextFeild: LeftPadedTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        self.borderStyle = .none
        self.borderWidth = 1
        self.borderColor = UIColor.appBorderColor
        self.cornerRadius = 8
        self.textColor = UIColor.appBlueColor
        self.font = UIFont(name: Utility.appFont.boldFont, size: 15)
        self.backgroundColor = .white
    }
    
}

