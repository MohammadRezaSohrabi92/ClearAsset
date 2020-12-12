//
//  BaseViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 12/12/2020.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationView()
        setupBackButton()
    }
    
    fileprivate func setupNavigationView() {
        navigationController?.navigationBar.tintColor = UIColor.appBlueColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Utility.appFont.semiBold, size: 19)!, NSAttributedString.Key.foregroundColor : UIColor.appBlueColor!]
    }
    
    fileprivate func setupBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(onTapBackButton(_:)))
        
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onTapBackButton(_:)))
    }
    
    @objc fileprivate func onTapBackButton(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setTitle(title: String) {
        navigationController?.title = title
        navigationController?.navigationItem.title = title
    }
    

}
