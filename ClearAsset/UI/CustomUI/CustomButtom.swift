//
//  CustomButtom.swift
//  ClearAsset
//
//  Created by Peyk Office on 08/12/2020.
//

import Foundation
import UIKit

@IBDesignable
class CustomButton : UIButton {
    
    @IBInspectable var isOrangeColor : Bool {
        get {
            return false
        } set {
            if newValue {
                self.backgroundColor = UIColor.appOrangeColor
            } else {
                self.backgroundColor = UIColor.appBlueColor
            }
        }
    }
    
    @IBInspectable var fontSize : CGFloat {
        get {
            return 30
        } set {
            self.titleLabel?.font = UIFont(name: Utility.appFont.boldFont, size: newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    fileprivate func setup() {
        self.cornerRadius = 8.0
        self.titleLabel?.font = UIFont(name: Utility.appFont.boldFont, size: fontSize)
        print(fontSize)
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .selected)
    }
    
    fileprivate func setOrangeButton() {
        self.backgroundColor = UIColor.appOrangeColor
    }
    
}
