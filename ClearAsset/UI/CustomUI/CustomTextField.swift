//
//  CustomTextField.swift
//  ClearAsset
//
//  Created by Peyk Office on 12/12/2020.
//

import Foundation
import UIKit

class CustomTextField : UITextField {
    
    lazy var visibleImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visible"))
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        initView()
    }
    
    fileprivate func setup() {
        self.backgroundColor = UIColor.appTextfieldBG
        self.font = UIFont(name: Utility.appFont.boldFont, size: 15)
        self.textColor = UIColor.appBlueColor
        self.cornerRadius = 8
        self.borderColor = UIColor.appBorderColor
        self.borderWidth = 1
    }
    
    func setupViews() {
        self.addSubview(visibleImageView)
        visibleImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        visibleImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        visibleImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        visibleImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    fileprivate func initView() {
        visibleImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnVisibleImageView(_:))))
    }
    
    @objc fileprivate func didTapOnVisibleImageView(_ sender: UITapGestureRecognizer) {
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 12, y: bounds.origin.y, width: bounds.width + 15, height: bounds.height)
        
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 12, y: bounds.origin.y, width: bounds.width + 15, height: bounds.height)
    }
    
}
