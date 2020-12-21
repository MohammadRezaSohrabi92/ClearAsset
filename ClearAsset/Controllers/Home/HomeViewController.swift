//
//  HomeViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 20/12/2020.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func buttonAction(_ sender: Any) {
//        let menu = SideMenuNavigationController(rootViewController: MenuViewController())
//        menu.leftSide = true
//        menu.menuWidth = self.view.layer.frame.width - (self.view.layer.frame.width / 6)
//        present(menu, animated: true)
        //let menu = AppStoryboard.Menu.viewController(viewControllerClass: MenuViewController.self) as! SideMenuNavigationController
        let sb = UIStoryboard(name: "Menu", bundle: nil)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        menu.menuWidth = self.view.layer.frame.width - (self.view.layer.frame.width / 6)
        present(menu, animated: true, completion: nil)
    }
    
}
