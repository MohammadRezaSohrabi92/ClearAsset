//
//  NotificationViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 02/01/2021.
//

import UIKit

class NotificationViewController: BaseViewController {

    
//MARK:- Views
    @IBOutlet weak var mainTable: UITableView!
    
//init var
    let notificationCellIdentifier = "NotificationTableViewCellIdentifier"

//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
    }
    
//MARK:- Other methods
    func initViews() {
        mainTable.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: notificationCellIdentifier)
    }
    
//MARK:- Actions
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }    
}

//MARK:- TableView Delegate and Data Source
extension NotificationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: notificationCellIdentifier, for: indexPath) as? NotificationTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175.0
    }
}
