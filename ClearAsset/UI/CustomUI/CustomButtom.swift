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
                setupOrangeButton()
            } else {
                self.backgroundColor = UIColor.appBlueColor
            }
        }
    }
    
    @IBInspectable var fontSize : CGFloat {
        get {
            return self.titleLabel?.font.pointSize ?? 18
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
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .selected)
    }
    
    fileprivate func setupOrangeButton() {
        self.backgroundColor = UIColor.appOrangeColor
        addShadow(shadowColor: UIColor.appOrangeColor!.cgColor, shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 1, shadowRadius: 8, cornerRadius: 8)
    }
    
}
