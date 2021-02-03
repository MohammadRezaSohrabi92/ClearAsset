//
//  SplashViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 18/01/2021.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    fileprivate var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        animationView = .init(name: "End")
        animationView.frame = view.bounds
        animationView!.contentMode = .scaleAspectFill
        animationView!.loopMode = .loop
        view.addSubview(animationView!)
        animationView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        animationView.play { (isFinished) in
            if isFinished {
                if self.isLoginedBefore() {
                    self.navigationController?.pushViewController(AppStoryboard.TabBar.viewController(viewControllerClass: TabBarViewController.self), animated: true)
                    return
                }
                self.navigationController?.pushViewController(AppStoryboard.Login.viewController(viewControllerClass: LoginViewController.self), animated: true)
            }
        }
    }
    
    fileprivate func isLoginedBefore() -> Bool {
        if let isLogined = Utility().reteriveData(inUserDefulat: "isLogined") as? Bool {
            if isLogined {
                return true
            }
            return false
        } else {
            return false
        }
    }
}
