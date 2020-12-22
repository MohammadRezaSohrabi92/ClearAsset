//
//  HomeViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 20/12/2020.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {

    //MARK:- views
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet private var mainTable: UITableView!

    //init var
    let mainTableIdentifer = "mainTableIdentifier"
    let secondCellIdentifier = "secondCellIdentifier"
    let middleCollectionIdentifier = "middleCollectionIdentifer"
    let bottomCellIdentifier = "bottomCellIdentifer"
    let bottomCollectionItemIdentifier = "bottomCollectionIdentifier"

    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
    }

    //MARK:- other methods
    func initViews() {
        mainTable.register(UINib(nibName: "TopViewCell", bundle: nil), forCellReuseIdentifier: mainTableIdentifer)
        mainTable.register(UINib(nibName: "MiddleTableViewCell", bundle: nil), forCellReuseIdentifier: secondCellIdentifier)
        mainTable.register(UINib(nibName: "BottomTableViewCell", bundle: nil), forCellReuseIdentifier: bottomCellIdentifier)
    }


    //MARK:- actions

    @IBAction func didTapOnMenuButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Menu", bundle: nil)
        let menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        menu.menuWidth = self.view.layer.frame.width - (self.view.layer.frame.width / 6)
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        present(menu, animated: true, completion: nil)
    }
    
}

//MARK:- TableView delegate and data source
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 4
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: mainTableIdentifer, for: indexPath) as? TopViewCell {
                return cell
            }
        } else if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: secondCellIdentifier, for: indexPath) as? MiddleTableViewCell {
                return cell
            }
        } else if indexPath.section == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: bottomCellIdentifier, for: indexPath) as? BottomTableViewCell {
                return cell
            }
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 370.0
        } else if indexPath.section == 1 {
            return 180.0
        } else if indexPath.section == 2 {
            return 310.0
        }
        return 400
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let tableViewCell = cell as? MiddleTableViewCell else { return }
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section)
        } else if indexPath.section == 2 {
            guard let tableViewCell = cell as? BottomTableViewCell else { return }
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section)
        }
    }

}

//MARK:- collectionview delegate and data source
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            if let item = collectionView.dequeueReusableCell(withReuseIdentifier: middleCollectionIdentifier, for: indexPath) as? MiddleCollectionViewCell {
                return item
            }
        } else if collectionView.tag == 2 {
            if let item = collectionView.dequeueReusableCell(withReuseIdentifier: bottomCollectionItemIdentifier, for: indexPath) as? BottomCollectionViewCell {
                return item
            }
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 265)
    }

}

//MARK:- sideMenu delegate
extension HomeViewController: SideMenuNavigationControllerDelegate {

    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
        menuButton.setImage(UIImage(named: "close"), for: .normal)
    }

    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
        menuButton.setImage(UIImage(named: "berger"), for: .normal)
    }
}
