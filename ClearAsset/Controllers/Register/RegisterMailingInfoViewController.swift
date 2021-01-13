//
//  RegisterMailingInfoViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 12/12/2020.
//

import UIKit
import DropDown

class RegisterMailingInfoViewController: BaseViewController {
    
    // MARK:- outlets
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var interestedView: UIView!
    @IBOutlet weak var industryView: UIView!
    @IBOutlet weak var countryLabel: CustomLabel!
    @IBOutlet weak var interestedLabel: CustomLabel!
    @IBOutlet weak var industryLabel: CustomLabel!
    @IBOutlet private weak var nextBtn: CustomButton!
    @IBOutlet weak var countryMenu: CustomDropDownMenu!
    @IBOutlet weak var interestedMenu: CustomDropDownMenu!
    @IBOutlet weak var industryMenu: CustomDropDownMenu!
    
    // MARK:- init var
    var getCountryViewModel: GetCountryViewModel!
    var allCountry: AllCountry?
    var selectedCountry = ""
    
    // MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    // MARK:- other methods
    fileprivate func initView() {
        nextBtn.setOnClick(onClick: #selector(onTapNextButton(_:)))
        getCountryViewModel = GetCountryViewModel()
        getAllCountry()
    }

    func getAllCountry() {
        Utility.showHudLoading()
        getCountryViewModel.getCountry { (allCountry, error) in
            if error == nil {
                Utility.hideHudLoading()
                if let counntries = allCountry {
                    self.allCountry = counntries
                    self.initCountries()
                }
            } else {
                Utility.hideHudLoading()
                self.showActionSheet(title: "error".getString(), message: error.debugDescription, style: .alert, actions: [self.actionMessageClose()])
            }
        }
    }

    func initCountries() {
        self.allCountry?.country.forEach({ (country) in
            self.countryMenu.dropDownMenu.dataSource.append(country.name)
        })
        if countryMenu.dropDownMenu.dataSource.isEmpty {
            return
        }
        self.countryMenu.textLabel.text = countryMenu.dropDownMenu.dataSource[0]
        onSelectCountryDropDownMenu()
    }

//MARK:- Actions
    @objc fileprivate func onTapNextButton(_ sender: UITapGestureRecognizer) {
        self.navigationController?.pushViewController(AppStoryboard.Register.viewController(viewControllerClass: RegisterCheckEmailViewController.self), animated: true)
    }

    func onSelectCountryDropDownMenu() {
        countryMenu.dropDownMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            countryMenu.textLabel.text = item
            selectedCountry = (allCountry?.country[index].name)!
        }
    }

}
