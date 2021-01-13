//
//  RegisterMailingInfoViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 12/12/2020.
//

import UIKit
import PhoneNumberKit
//import CountryPickerView

class RegisterMailingInfoViewController: BaseViewController {
    
    // MARK:- outlets
    @IBOutlet weak var industryLabel: CustomLabel!
    @IBOutlet weak var nextBtn: CustomButton!
    @IBOutlet weak var countryMenu: CustomDropDownMenu!
    @IBOutlet weak var interestedMenu: CustomDropDownMenu!
    @IBOutlet weak var industryMenu: CustomDropDownMenu!
    @IBOutlet weak var phoneNumberTextField: PhoneNumberTextField!
    //@IBOutlet weak var countryPicker: CountryPickerView!
    
    // MARK:- init var
    let phoneNumberKit = PhoneNumberKit()
    var getCountryViewModel: GetCountryViewModel!
    var allCountry: AllCountry?
    var selectedCountry = ""
    var getPrimaryViewModel: GetPrimaryViewModel!
    var primaryList: Primary?
    var selectedPrimaryIndustry = ""
    var interested = ""
    
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
        getPrimaryViewModel = GetPrimaryViewModel()
        getAllCountry()
        getAllPrimaryData()
        initIntrested()
        initPhoneNumberTextField()
    }

    func initPhoneNumberTextField() {
        phoneNumberTextField.withPrefix = true
        phoneNumberTextField.withFlag = true
        phoneNumberTextField.withExamplePlaceholder = true
        phoneNumberTextField.font = UIFont(name: Utility.appFont.semiBold, size: 15)
        phoneNumberTextField.textColor = UIColor.appBlueColor
//        countryPicker.showPhoneCodeInView = false
//        countryPicker.showCountryCodeInView = false
//        countryPicker.delegate = self
//        if let phoneNumber = phoneNumberTextField.phoneNumber {
//            countryPicker.setCountryByCode("\(phoneNumber.countryCode)")
//        }
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
        guard let countries = allCountry?.country, !countries.isEmpty else {return}
        self.allCountry?.country.forEach({ (country) in
            self.countryMenu.dropDownMenu.dataSource.append(country.name)
        })
        self.countryMenu.textLabel.text = countryMenu.dropDownMenu.dataSource[0]
        onSelectCountryDropDownMenu()
    }

    func getAllPrimaryData() {
        Utility.showHudLoading()
        getPrimaryViewModel.getPrimary { (primary, error) in
            if error == nil {
                Utility.hideHudLoading()
                self.primaryList = primary
                self.initPrimaryIndustryList()
            } else {
                Utility.hideHudLoading()
                self.showActionSheet(title: "error".getString(), message: error!.localizedDescription, style: .alert, actions: [self.actionMessageClose()])
            }
        }
    }

    func initPrimaryIndustryList() {
        guard let list = primaryList?.primary, !list.isEmpty else {return}
        list.forEach { (title) in
            industryMenu.dropDownMenu.dataSource.append(title)
        }
        industryMenu.textLabel.text = industryMenu.dropDownMenu.dataSource[0]
        onSelectPrimaryIndustryDropDownMenu()
    }

    func initIntrested() {
        interestedMenu.dropDownMenu.dataSource = ["Buying", "Selling"]
        interestedMenu.textLabel.text = interestedMenu.dropDownMenu.dataSource[0]
        onSelectedInterestedDropDownMenu()
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

    func onSelectPrimaryIndustryDropDownMenu() {
        industryMenu.dropDownMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            industryMenu.textLabel.text = item
            selectedPrimaryIndustry = item
        }
    }

    func onSelectedInterestedDropDownMenu() {
        interestedMenu.dropDownMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            interestedMenu.textLabel.text = item
            interested = item
        }
    }

}


//MARK:- extensions
//extension RegisterMailingInfoViewController: CountryPickerViewDelegate {
//    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
//        self.phoneNumberTextField.text = country.phoneCode
//    }
//}
