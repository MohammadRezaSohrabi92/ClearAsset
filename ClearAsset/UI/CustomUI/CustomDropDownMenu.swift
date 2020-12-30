//
//  File.swift
//  ClearAsset
//
//  Created by Peyk Office on 13/12/2020.
//

import Foundation
import UIKit
import DropDown

class CustomDropDownMenu: UIView {
    
    //init var
    let dropDownMenu = DropDown()
    
    @IBInspectable var isRegister: Bool {
        get {
            return true
        } set {
            if !newValue {
                backView.backgroundColor = .white
                bottomArrow.tintColor = UIColor.appGray
            } else {
                backView.backgroundColor = UIColor.appTextfieldBG
                bottomArrow.tintColor = UIColor.appOrangeColor
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
        setupViews()
        initViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    lazy var backView: UIView = {
        let view = UIView()        
        view.cornerRadius = 8
        view.borderColor = UIColor.appBorderColor
        view.borderWidth = 1
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var textLabel: CustomLabel = {
        let lb = CustomLabel()
        lb.isTitle = true
        lb.setupTitleAttribute()        
        lb.textColor = UIColor.appBlueColor
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var bottomArrow: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "arrowBottom"))
        iv.image = iv.image?.withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    fileprivate func setupViews() {
        self.addSubview(backView)
        backView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        backView.addSubview(textLabel)
        textLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12).isActive = true
        
        backView.addSubview(bottomArrow)
        bottomArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bottomArrow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        bottomArrow.widthAnchor.constraint(equalToConstant: 20).isActive = true
        bottomArrow.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    fileprivate func initViews() {
        dropDownMenu.anchorView = backView
        dropDownMenu.textFont = UIFont(name: Utility.appFont.semiBold, size: 15)!
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnMenu(_:))))
        dropDownMenu.dataSource = ["Car", "type", "Dog", "Animal"]
    }
    
    @objc func didTapOnMenu(_ sender: UITapGestureRecognizer) {
        dropDownMenu.show()
    }
    
}


