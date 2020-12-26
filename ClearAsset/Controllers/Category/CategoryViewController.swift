//
//  CategoryViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 26/12/2020.
//

import UIKit
import SideMenu

class CategoryViewController: UIViewController {
    
    //MARK:- Views
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    
    //init var
    let categoryTableViewCellIdentifier = "categoryTableViewCellIdentifier"
    let categoryCollectionViewItemIdentifier = "categoryCollectionViewItemIdentifier"
    let subCategoryCell = "subCategoryCellIdentifier"
    var menu : SideMenuNavigationController!
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    //MARK:- other methods
    
    func initViews() {
        initMenu()
        mainTable.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: categoryTableViewCellIdentifier)
        mainTable.register(UINib(nibName: "SubCategoryCell", bundle: nil), forCellReuseIdentifier: subCategoryCell)
    }
    
    func initMenu() {
        let sb = UIStoryboard(name: "Menu", bundle: nil)
        menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as? SideMenuNavigationController
        menu.menuWidth = self.view.layer.frame.width - (self.view.layer.frame.width / 6)
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
    
    
    @IBAction func didTapOnMenu(_ sender: Any) {
        present(menu, animated: true, completion: nil)
    }
    
}

//MARK:- TableView delegate and Data Source
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: categoryTableViewCellIdentifier, for: indexPath) as? CategoryTableViewCell {
                return cell
            }
        } else if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: subCategoryCell, for: indexPath) as? SubCategoryCell {
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let tableViewCell = cell as? CategoryTableViewCell else { return }
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        }
        return 70
    }
}

    //MARK:- CollectionView Delegate and Data Source
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let item = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCollectionViewItemIdentifier, for: indexPath) as? CategoryCollectionViewCell {
            return item
        }
        return UICollectionViewCell()
    }
    
    
}
