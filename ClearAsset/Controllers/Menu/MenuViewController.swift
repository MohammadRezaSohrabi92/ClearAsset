//
//  TestViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 20/12/2020.
//

import UIKit

class MenuViewController: UIViewController {
    
    //MARK:- Views
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var profileView: UIView!
    
    //init var
    let menuCellIdentifier = "MenuCellIdentifier"
    let items = ["My Sale", "Watch List", "Auctions", "Notifications", "Settings", "Support", "FAQ", "Log Out"]
    let itemsImage = ["mySale", "watchList", "auctions", "notifications", "settings", "support", "faq", "logOut"]
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        initViews()
    }
    
    fileprivate func initViews() {
        table.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: menuCellIdentifier)
        profileView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnProfileView(_:))))
    }
    
    //MARK:- Other methods
    
    //MARK:- actions
    @objc func didTapOnProfileView(_ sender: UITapGestureRecognizer) {
        self.navigationController?.pushViewController(AppStoryboard.Profile.viewController(viewControllerClass: ProfileViewController.self), animated: true)
    }

}

    //MARK:- tableView extensions
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: menuCellIdentifier, for: indexPath) as? MenuTableViewCell {
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.fillCell(title: items[indexPath.row], imageName: itemsImage[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let watchListVC = AppStoryboard.WatchList.viewController(viewControllerClass: WatchListViewController.self)
            watchListVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(watchListVC, animated: true)
        }
        if indexPath.row == 3 {
            let notificationVC = AppStoryboard.Notification.viewController(viewControllerClass: NotificationViewController.self)
            notificationVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(notificationVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

