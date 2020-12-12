//
//  RegisterAboutYourselfViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 12/12/2020.
//

import UIKit

class RegisterAboutYourselfViewController: BaseViewController {
    
    @IBOutlet private var nextButton: CustomButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    fileprivate func initView() {
        nextButton.setOnClick(onClick: #selector(onTapNextButton(_:)))
    }
    
    @objc fileprivate func onTapNextButton(_ sender: UITapGestureRecognizer) {
        let nextVC = AppStoryboard.Register.viewController(viewControllerClass: RegisterMailingInfoViewController.self)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
