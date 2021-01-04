//
//  FilterViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 02/01/2021.
//

import UIKit

class FilterViewController: BaseViewController {

//MARK:- Views
    @IBOutlet weak var mainTable: UITableView!
    
 
//init var
    let filterCellIdentifier = "FilterTableViewCellIdentifier"
    
//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
    }
    
//MARK:- Other Methods
    func initViews() {
        mainTable.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: filterCellIdentifier)
    }

//MARK:- Actions
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: filterCellIdentifier, for: indexPath) as? FilterTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let background = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let imageView = UIImageView.init(frame: CGRect(x: 10, y: 12.5, width: 25, height: 25))
        imageView.image = UIImage(named: "filterCellIcon")
        background.addSubview(imageView)
        let headerLabel = UILabel.init(frame: CGRect(x: 44, y: 15, width: 100, height: 20))
        headerLabel.text = "Category"
        headerLabel.font = UIFont(name: Utility.appFont.boldFont, size: 18)
        headerLabel.textColor = UIColor.appGray
        background.addSubview(headerLabel)
        return background
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let background = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 4.0))
        let line = UIView.init(frame: CGRect(x: 0, y: 2, width: tableView.frame.width, height: 1.0))
        line.backgroundColor = UIColor.appBorderColor
        background.addSubview(line)
        return background
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4.0
    }
}
