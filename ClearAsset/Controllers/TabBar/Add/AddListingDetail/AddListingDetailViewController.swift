//
//  AddListingDetailViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 27/12/2020.
//

import UIKit
import DropDown

class AddListingDetailViewController: BaseViewController {
    
//MARK:- Views    
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var mainTableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addMoreDetailButton: UIView!
    
//init var
    let dropDownMenu = DropDown()
    let contentViewHeight: CGFloat = 1550
    let mainTableHeightConstant: CGFloat = 470
    var numberOfRows = 1
    var detailTitle = "Transmission Details"
    let detailTVcellIdentiifer = "detailTableViewCellIdentifier"
    let transmissionDetailCVIdentifier = "transmissionDetailCollectionViewIdentifier"

//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.mainTableHeightConstraint?.constant = self.mainTable.contentSize.height
        contentViewHeightConstraint.constant = self.mainTable.contentSize.height > mainTableHeightConstant ? mainTableHeightConstraint.constant + contentViewHeight - mainTableHeightConstant : contentViewHeight
    }
    
//MARK:- Other Methods
    func initViews() {
        mainTable.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: detailTVcellIdentiifer)
        mainTable.rowHeight = UITableView.automaticDimension
        addMoreDetailButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnAddMoreDetailButton(_:))))
        initDropDownMenu()
    }
    
    func initDropDownMenu() {
        dropDownMenu.anchorView = addMoreDetailButton
        dropDownMenu.dismissMode = .onTap
        dropDownMenu.textFont = UIFont(name: Utility.appFont.semiBold, size: 15)!
        dropDownMenu.cellNib = UINib(nibName: "MoreDetailCell", bundle: nil)
        dropDownMenu.dataSource = ["Car", "type", "Dog", "Animal"]
        dropDownMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            numberOfRows += 1
            detailTitle = item
            mainTable.reloadData()
            viewWillLayoutSubviews()
        }
    }
    
//MARK:- Actions
    @objc func didTapOnAddMoreDetailButton(_ sender: UITapGestureRecognizer) {
        dropDownMenu.show()
    }
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- TableView delegate and data source

extension AddListingDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: detailTVcellIdentiifer, for: indexPath) as? DetailTableViewCell {
            cell.mainTitleLabel.text = detailTitle
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? DetailTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forCell: indexPath.row)
    }
}

    //MARK:- CollectionView Delegate and Data Source
extension AddListingDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let item = collectionView.dequeueReusableCell(withReuseIdentifier: transmissionDetailCVIdentifier, for: indexPath) as? AddTransmissionCollectionViewCell {
            return item
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
}
