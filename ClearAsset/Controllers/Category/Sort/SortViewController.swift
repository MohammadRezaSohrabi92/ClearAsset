//
//  SortViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 03/01/2021.
//

import UIKit

class SortViewController: UIViewController {

//MARK:- Views
    @IBOutlet weak var mainTable: UITableView!

//init var
    let sortCellIdentifier = "SortTableViewCellIdentifier"
    let sortListItems = ["Best", "Year", "Price Low", "Price Highest", "Closest to me"]
    
//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
    }
    
//MARK:- Other methods
    func initViews() {
        mainTable.register(UINib(nibName: "SortTableViewCell", bundle: nil), forCellReuseIdentifier: sortCellIdentifier)
    }
    
//MARK:- Actions
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- TableView Delegate and Data Source
extension SortViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: sortCellIdentifier, for: indexPath) as? SortTableViewCell {
            cell.titleLabel.text = sortListItems[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
    }
}
