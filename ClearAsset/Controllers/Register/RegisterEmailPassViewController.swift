//
//  RegisterEmailPassViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 12/12/2020.
//

import UIKit

class RegisterEmailPassViewController: BaseViewController {
    
    @IBOutlet private var nextButton: CustomButton!

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
    }
    
    @objc fileprivate func onTapNextButton(_ sender: UITapGestureRecognizer) {        
        let nextVC = AppStoryboard.Register.viewController(viewControllerClass: RegisterAboutYourselfViewController.self)
        self.navigationController?.pushViewController(nextVC, animated: true)        
    }

}
