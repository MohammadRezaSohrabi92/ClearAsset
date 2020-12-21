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
    }
    
    //MARK:- Other methods

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: menuCellIdentifier, for: indexPath) as? MenuTableViewCell {
            cell.selectionStyle = .gray
            cell.accessoryType = .disclosureIndicator
            cell.fillCell(title: items[indexPath.row], imageName: itemsImage[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

}
