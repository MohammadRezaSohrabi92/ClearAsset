//
//  SelectListingCategoryViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 29/12/2020.
//

import UIKit
import SideMenu

class SelectListingCategoryViewController: UIViewController {
    
//MARK:- Views
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    
//init view
    let selectCategoryCellIdentifier = "selectCategoryTableViewCellIdentifier"
    var menu: SideMenuNavigationController!
    
//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
    }
    
//MARK:- Other methods

    func initViews() {
        mainTable.register(UINib(nibName: "SelectCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: selectCategoryCellIdentifier)
        initMenu()
    }
    
    func initMenu() {
        let sb = UIStoryboard(name: "Menu", bundle: nil)
        menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as? SideMenuNavigationController
        menu.menuWidth = self.view.layer.frame.width - (self.view.layer.frame.width / 6)
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
    
//MARK:- actions
    @IBAction func didTapOnMenuButton(_ sender: Any) {
        present(menu, animated: true, completion: nil)
    }
    
}

//MARK:- extensions

extension SelectListingCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: selectCategoryCellIdentifier, for: indexPath) as? SelectCategoryTableViewCell {
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectSubCategoryVC = AppStoryboard.Add.viewController(viewControllerClass: SelectSubCategoryViewController.self)
        self.navigationController?.pushViewController(selectSubCategoryVC, animated: true)
    }

}
