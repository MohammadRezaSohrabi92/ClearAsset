//
//  RegisterCheckEmailViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 14/12/2020.
//

import UIKit

class RegisterCheckEmailViewController: BaseViewController {
    
    //MARK:- views

    
    //init var
    
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        
    }
    
    
    //MARK:- Other methods
    fileprivate func initViews() {
        
    }
    
    //MARK:- actions
    
    @IBAction func didTapOnSkipButton(_ sender: Any) {
        let vc = AppStoryboard.TabBar.viewController(viewControllerClass: TabBarViewController.self)
        vc.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
