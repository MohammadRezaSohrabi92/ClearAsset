//
//  ServicePreviewViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 27/12/2020.
//

import UIKit

class ServicePreviewViewController: UIViewController {
    
    //MARK:- Views
    @IBOutlet weak var mainTable: UITableView!
    
    
    //init var
    let mainTableIdentifier = "ServicePreviewTableViewCellIdentifier"
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    //MARK:- Other methods
    func initView() {
        mainTable.register(UINib(nibName: "ServicePreviewTableViewCell", bundle: nil), forCellReuseIdentifier: mainTableIdentifier)
    }

}

    //MARK:- tableView delegate and data source
extension ServicePreviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: mainTableIdentifier, for: indexPath) as? ServicePreviewTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}
