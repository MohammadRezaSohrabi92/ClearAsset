//
//  CustomAddTitle.swift
//  ClearAsset
//
//  Created by Peyk Office on 27/12/2020.
//

import Foundation
import UIKit

class CustomAddTitle: UILabel {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTitle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupTitle() {
        self.font = UIFont(name: Utility.appFont.boldFont, size: 17)
        self.textColor = UIColor.appGray
    }
}
