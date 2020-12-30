//
//  AddViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 26/12/2020.
//

import UIKit

class SelectSubCategoryViewController: BaseViewController {
    
//MARK:- Views
    
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var profilePhoto: UIImageView!
    
    
    //init var
    let addListingCellIdentifier = "addListingCellIdentifier"
    
//MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    
    //MARK: other methods
    func initView() {
        mainTable.register(UINib(nibName: "AddListingTableViewCell", bundle: nil), forCellReuseIdentifier: addListingCellIdentifier)
    }

//MARK:- Actions
    
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


    //MARK:- tableView delegate and data source
extension SelectSubCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(AppStoryboard.Add.viewController(viewControllerClass: AddListingDetailViewController.self), animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: addListingCellIdentifier, for: indexPath) as? AddListingTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
