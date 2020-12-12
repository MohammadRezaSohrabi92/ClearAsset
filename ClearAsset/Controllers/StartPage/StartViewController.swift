//
//  StartViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 07/12/2020.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var btnGetStarted: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnGetStartedAction(_ sender: Any) {
        //code
        self.navigationController?.pushViewController(AppStoryboard.Login.viewController(viewControllerClass: LoginViewController.self), animated: true)
    }

}
