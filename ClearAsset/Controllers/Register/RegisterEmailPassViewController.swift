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
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var rePasswordView: UIView!
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    ///init var
    var visibleClick = false
    var step1ViewModel: RegisterStep1ViewModel!    
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        step1ViewModel = RegisterStep1ViewModel()
        initScrollView(self.mScrollView)
    }
    
    fileprivate func goToNextStep() {
        let nextVC = AppStoryboard.Register.viewController(viewControllerClass: RegisterAboutYourselfViewController.self)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    fileprivate func returnToDefaultView() {
        emailTF.borderColor = UIColor.appBorderColor
        passwordView.borderColor = UIColor.appBorderColor
        rePasswordView.borderColor = UIColor.appBorderColor
    }
    
    func showError(error: ErrorMessageModel) {
        switch error.code {
        case 1:
            emailTF.borderColor = .red
            emailTF.becomeFirstResponder()
            break
        case 2:
            passwordView.borderColor = .red
            passwordTF.becomeFirstResponder()
            break
        case 3:
            rePasswordView.borderColor = .red
            rePasswordTF.becomeFirstResponder()
            break
        default:
            break
        }
    }

    //MARK:- Actions
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
        returnToDefaultView()
        Utility.showHudLoading()
        step1ViewModel.register(byEmail: emailTF.text, password: passwordTF.text, rePassword: rePasswordTF.text) { (response, error) in
            if error == nil {
                Utility.hideSuccessHudLoading()
                self.goToNextStep()
            } else {
                Utility.hideHudLoading()
                self.showActionSheet(title: "error", message: error!.message, style: .alert, actions: [self.actionMessageClose()])
                self.showError(error: error!)
            }
        }
    }
}

//MARK:- extensionss
extension RegisterEmailPassViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.activeField = nil
        return true
    }
}
