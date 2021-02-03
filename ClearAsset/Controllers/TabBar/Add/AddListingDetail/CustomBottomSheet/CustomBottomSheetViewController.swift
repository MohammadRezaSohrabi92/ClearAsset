//
//  CustomBottomSheetViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 01/02/2021.
//

import UIKit

protocol GetSelectedDescription {
    func getSelectedText(text: String)    
}

class CustomBottomSheetViewController: UIViewController {

//MARK:- Views
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var backViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainTableHeightConstraint: NSLayoutConstraint!
    
//init var
    let backViewHeight: CGFloat = 150
    let mainTableHeight: CGFloat = 50
    let cellIdentifier = "BottomSheetCellIdentifier"
    var descList : [String]?
    var titleLabelText : String?
    var selectedDesc : String?
    var delegate: GetSelectedDescription!

//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.mainTableHeightConstraint?.constant = self.mainTable.contentSize.height
        backViewHeightConstraint.constant = self.mainTable.contentSize.height > mainTableHeight ? mainTableHeightConstraint.constant + backViewHeight - mainTableHeight : backViewHeight
    }
    
//MARK:- Other Methods
    func initView() {
        mainTable.register(UINib(nibName: "CustomBottomSheetTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        mainTable.isScrollEnabled = false
        if let text = titleLabelText {
            titleLabel.text = text
        }
    }
    
    
//MARK:- Actions
    
}

//MARK:- Extensions
extension CustomBottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = descList {
            return list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomBottomSheetTableViewCell {
            cell.descLabel.text = descList![indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDesc = descList![indexPath.row]
        if let text = selectedDesc {
            self.dismiss(animated: true, completion: nil)
            delegate.getSelectedText(text: text)
        }
    }
}
