//
//  TabBarViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 20/12/2020.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBarController?.tabBar.tintColor = UIColor.appOrangeColor
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.appBlueColor
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
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
