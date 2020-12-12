//
//  CustomLabel.swift
//  ClearAsset
//
//  Created by Peyk Office on 12/12/2020.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    
    let titleFontSize :CGFloat = 19
    let descriptionFontSize :CGFloat = 14
    let lightTitleFontSize :CGFloat = 15
    
    @IBInspectable var isTitle : Bool {
        get {
            return false
        } set {
            if newValue {
                setupTitleAttribute()
            } else {
                setupDescriptionAttribute()
            }
        }
    }
    
    @IBInspectable var isLightTitle: Bool {
        get {
            return false
        } set {
            if newValue {
                setupLightTitleAttribute()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    fileprivate func setup() {
        self.textColor = UIColor.appBlueColor
    }
    
    fileprivate func setupTitleAttribute() {
        self.font = UIFont(name: Utility.appFont.boldFont, size: titleFontSize)
    }
    
    fileprivate func setupDescriptionAttribute() {
        self.font = UIFont(name: Utility.appFont.semiBold, size: descriptionFontSize)
    }
    
    fileprivate func setupLightTitleAttribute() {
        self.font = UIFont(name: Utility.appFont.semiBold, size: lightTitleFontSize)
        self.textColor = UIColor.appBlueLightAlpha
    }
}
