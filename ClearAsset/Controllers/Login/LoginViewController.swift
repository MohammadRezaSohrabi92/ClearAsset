//
//  LoginViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 08/12/2020.
//

import UIKit

class LoginViewController: UIViewController {
    
//MARK:- Views
    @IBOutlet weak var emailAddressTF: CustomTextField!
    @IBOutlet weak var passwordTF: CustomTextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
//init var
    var loginViewModel: LoginViewModel!
    
//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
//MARK:- Other Actions
    fileprivate func initView() {
        loginViewModel = LoginViewModel()
    }
    
    fileprivate func goToNextPage() {
        self.navigationController?.pushViewController(AppStoryboard.TabBar.viewController(viewControllerClass: TabBarViewController.self), animated: true)
    }
    
    fileprivate func returnToDefaultView() {
        emailAddressTF.borderColor = UIColor.appBorderColor
        passwordTF.borderColor = UIColor.appBorderColor
    }
    
    fileprivate func isFirstLaunch() {
        Utility().saveData(inUserDefulat: true, keyOfUserDefault: "isLogined")
    }
    
    func showError(error: ErrorMessageModel) {
        switch error.code {
        case 1:
            emailAddressTF.borderColor = .red
            emailAddressTF.becomeFirstResponder()
            break
        case 2:
            passwordTF.borderColor = .red
            passwordTF.becomeFirstResponder()
            break
        default:
            break
        }
    }
    
//MARK:- Api call
    fileprivate func login() {
        Utility.showHudLoading()
        loginViewModel.login(byEmail: emailAddressTF.text, password: passwordTF.text) { (data, error) in
            if error == nil {
                Utility.hideSuccessHudLoading()
                self.isFirstLaunch()
                self.goToNextPage()
            } else {
                Utility.hideHudLoading()
                self.showActionSheet(title: "error".getString(), message: error!.message, style: .alert, actions: [self.actionMessageClose()])
                self.showError(error: error!)
            }
        }
    }

//MARK:- Actions
    @IBAction func didTapOnLoginButton(_ sender: Any) {
        login()
    }
    
    @IBAction func didTapOnSignUpButton(_ sender: Any) {
        self.navigationController?.pushViewController(AppStoryboard.Register.viewController(viewControllerClass: RegisterEmailPassViewController.self), animated: true)
    }
    
}
