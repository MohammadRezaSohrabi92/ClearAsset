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
    var getSubCategoryViewModel: GetSubCategoryViewModel!
    var subCategories: Categories!
    var allSubCategories: [Category]!
    var id: String?
    
//MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
        
//MARK:- other methods
    func initView() {
        mainTable.register(UINib(nibName: "AddListingTableViewCell", bundle: nil), forCellReuseIdentifier: addListingCellIdentifier)
        getSubCategoryViewModel = GetSubCategoryViewModel()
        getSubCategories()
    }
    
    fileprivate func fillTableView() {
        guard let allSubCategories = subCategories.categories, !allSubCategories.isEmpty else {return}
        self.allSubCategories = allSubCategories
        mainTable.reloadData()
    }

//MARK:- Actions
    
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
//MARK:- Api call
    fileprivate func getSubCategories() {
        Utility.showHudLoading()
        guard let id = id else {
            Utility.hideHudLoading()
            return
        }
        getSubCategoryViewModel.getSubCategory(id: id) { (subCategories, error) in
            if error == nil {
                Utility.hideHudLoading()
                self.subCategories = subCategories
                self.fillTableView()
            } else {
                Utility.hideHudLoading()
                self.showActionSheet(title: "error".getString(), message: error!.localizedDescription, style: .alert, actions: [self.actionMessageClose()])
            }
        }
    }
    
}
//MARK:- tableView delegate and data source
extension SelectSubCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let allSubCategories = allSubCategories, !allSubCategories.isEmpty {
            return allSubCategories.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addDetailVC = AppStoryboard.Add.viewController(viewControllerClass: AddListingDetailViewController.self)
        addDetailVC.categoryId = id
        self.navigationController?.pushViewController(addDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: addListingCellIdentifier, for: indexPath) as? AddListingTableViewCell {
            cell.subCategoryTitle.text = self.allSubCategories[indexPath.row].name
            cell.subCategoryImageVIew.sd_setImage(with: URL(string: self.allSubCategories[indexPath.row].pic!), placeholderImage: UIImage(named: "car"))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
