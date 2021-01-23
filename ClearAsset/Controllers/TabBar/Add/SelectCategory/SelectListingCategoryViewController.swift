//
//  SelectListingCategoryViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 29/12/2020.
//

import UIKit
import SideMenu
import SDWebImage

class SelectListingCategoryViewController: UIViewController {
    
//MARK:- Views
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    
//init view
    let selectCategoryCellIdentifier = "selectCategoryTableViewCellIdentifier"
    var menu: SideMenuNavigationController!
    var getCategoryViewModel: GetCategoryViewModel!
    var categories : Categories!
    var allCategories: [Category]!
    
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
        getCategoryViewModel = GetCategoryViewModel()
        getCategories()
    }
    
    func initMenu() {
        let sb = UIStoryboard(name: "Menu", bundle: nil)
        menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as? SideMenuNavigationController
        menu.menuWidth = self.view.layer.frame.width - (self.view.layer.frame.width / 6)
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
    
    func fillTableView() {
        guard let allCategories = categories.categories, !allCategories.isEmpty else {return}
        self.allCategories = allCategories
        mainTable.reloadData()
    }
    
//MARK:- actions
    @IBAction func didTapOnMenuButton(_ sender: Any) {
        present(menu, animated: true, completion: nil)
    }
    
//MARK:- Api call
    func getCategories() {
        Utility.showHudLoading()
        self.getCategoryViewModel.getCategory { (categories, error) in
            if error == nil {
                Utility.hideHudLoading()
                if let mCategories = categories {
                    self.categories = mCategories
                    self.fillTableView()
                }
            } else {
                Utility.hideHudLoading()
                self.showActionSheet(title: "error".getString(), message: error!.localizedDescription, style: .alert, actions: [self.actionMessageClose()])
            }
        }
    }
    
} //end class

//MARK:- extensions

extension SelectListingCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let allCategories = self.allCategories, !allCategories.isEmpty {
            return allCategories.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: selectCategoryCellIdentifier, for: indexPath) as? SelectCategoryTableViewCell {
            cell.title.text = allCategories[indexPath.row].name
            cell.categoryimage?.sd_setImage(with: URL(string: allCategories[indexPath.row].pic!), placeholderImage: UIImage(named: "OilGasBack"))            
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectSubCategoryVC = AppStoryboard.Add.viewController(viewControllerClass: SelectSubCategoryViewController.self)
        selectSubCategoryVC.id = ("\(allCategories[indexPath.row].id!)")
        self.navigationController?.pushViewController(selectSubCategoryVC, animated: true)
    }

}
