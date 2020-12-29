//
//  LoginViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 08/12/2020.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnLoginButton(_ sender: Any) {
        self.navigationController?.pushViewController(AppStoryboard.Register.viewController(viewControllerClass: RegisterEmailPassViewController.self), animated: true)
    }
}
