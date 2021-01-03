//
//  FilterViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 02/01/2021.
//

import UIKit

class ProductListViewController: BaseViewController {
    
//MARK:- Views
    @IBOutlet weak var filterButton: UIView!
    @IBOutlet weak var sortButton: UIView!
    @IBOutlet weak var mainTable: UITableView!
    
//init var
    let productListCellIdentifier = "ProductListCellIdentifier"
    
//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    
//MARK:- Other Methods
    func initView() {
        mainTable.register(UINib(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: productListCellIdentifier)
        filterButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnFilter(_:))))
        sortButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnSort(_:))))
    }
    
//MARK:- Actions
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapOnFilter(_ sender: UITapGestureRecognizer) {
        let filterVC = AppStoryboard.Filter.viewController(viewControllerClass: FilterViewController.self)
        filterVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    
    @objc func didTapOnSort(_ sender: UITapGestureRecognizer) {
        let sortVC = AppStoryboard.Sort.viewController(viewControllerClass: SortViewController.self)
        sortVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(sortVC, animated: true)
    }
    
}

//MARK:- TableView Delegate and Data Source
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: productListCellIdentifier, for: indexPath) as? ProductListTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 430.0
    }
}
