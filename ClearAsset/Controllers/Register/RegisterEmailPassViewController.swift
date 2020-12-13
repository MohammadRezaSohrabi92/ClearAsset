//
//  RegisterEmailPassViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 12/12/2020.
//

import UIKit

class RegisterEmailPassViewController: BaseViewController {
    
    @IBOutlet private var nextButton: CustomButton!
    @IBOutlet weak var passwordTF: CustomTextField!
    @IBOutlet weak var rePasswordTF: CustomTextField!
    
    //init var
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.    
        setTitle(title: "Register")
        initView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setTitle(title: "Register")
    }
    
    fileprivate func initView() {
        nextButton.setOnClick(onClick: #selector(onTapNextButton(_:)))
        passwordTF.setupViews()
        rePasswordTF.setupViews()
        passwordTF.visibleImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnVisibleImageView(_:))))
    }
    
    @objc fileprivate func didTapOnVisibleImageView(_ sender: UITapGestureRecognizer) {
        print("helooooooo")
        if(iconClick == true) {
            passwordTF.isSecureTextEntry = false
        } else {
            passwordTF.isSecureTextEntry = true
        }        
        iconClick = !iconClick
    }
    
    @objc fileprivate func onTapNextButton(_ sender: UITapGestureRecognizer) {
        let nextVC = AppStoryboard.Register.viewController(viewControllerClass: RegisterAboutYourselfViewController.self)
        self.navigationController?.pushViewController(nextVC, animated: true)        
    }

}
