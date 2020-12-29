//
//  ServicePreviewViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 27/12/2020.
//

import UIKit

class ServicePreviewViewController: BaseViewController {
    
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
    
//MARK:- actions
    
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = AppStoryboard.Services.viewController(viewControllerClass: ServiceDetailViewController.self)
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
