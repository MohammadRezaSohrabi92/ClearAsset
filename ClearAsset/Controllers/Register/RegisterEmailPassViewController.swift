//
//  RegisterEmailPassViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 12/12/2020.
//

import UIKit

class RegisterEmailPassViewController: BaseViewController {
    
    //MARK:- views
    @IBOutlet private var emailTF: CustomTextField!
    @IBOutlet private var nextButton: CustomButton!
    @IBOutlet private var passwordTF: CustomTextField!
    @IBOutlet private var rePasswordTF: CustomTextField!
    @IBOutlet private var visiblePassword: UIImageView!
    @IBOutlet private var visibleRePassword: UIImageView!
    
    ///init var
    var visibleClick = false
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //MARK:- Other methods
    fileprivate func initView() {
        nextButton.setOnClick(onClick: #selector(onTapNextButton(_:)))
        [passwordTF, rePasswordTF].forEach { (tf) in
            tf?.isSecureTextEntry = true
        }
        [visiblePassword, visibleRePassword].forEach { (iv) in
            iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnVisibleImageView(_:))))
        }
    }
    
    @objc fileprivate func didTapOnVisibleImageView(_ sender: UITapGestureRecognizer) {
        if(visibleClick == true) {
            [passwordTF, rePasswordTF].forEach { (tf) in
                tf?.togglePasswordVisibility()
            }
        } else {
            [passwordTF, rePasswordTF].forEach { (tf) in
                tf?.togglePasswordVisibility()
            }
        }        
        visibleClick = !visibleClick
    }
    
    @objc fileprivate func onTapNextButton(_ sender: UITapGestureRecognizer) {
        let nextVC = AppStoryboard.Register.viewController(viewControllerClass: RegisterAboutYourselfViewController.self)
        self.navigationController?.pushViewController(nextVC, animated: true)        
    }

}
