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
        
    }
    
    
    //MARK:- Other methods
    fileprivate func initViews() {
        
    }
    
    //MARK:- actions
    
    @IBAction func didTapOnSkipButton(_ sender: Any) {
        self.navigationController?.pushViewController(AppStoryboard.TabBar.viewController(viewControllerClass: TabBarViewController.self), animated: true)
    }
    
}
