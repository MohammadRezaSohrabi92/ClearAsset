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
    @IBOutlet weak var addressLine1TF: CustomTextField!
    @IBOutlet weak var addressLine2TF: CustomTextField!
    @IBOutlet weak var cityTF: CustomTextField!
    @IBOutlet weak var stateTF: CustomTextField!
    @IBOutlet weak var zipTF: CustomTextField!
    @IBOutlet weak var phoneNumberVIew: UIView!
    
    // MARK:- init var
    let phoneNumberKit = PhoneNumberKit()
    var getCountryViewModel: GetCountryViewModel!
    var allCountry: AllCountry?
    var selectedCountry = ""
    var getPrimaryViewModel: GetPrimaryViewModel!
    var primaryList: Primary?
    var selectedPrimaryIndustry = ""
    var selectedInterested = ""
    var step3ViewModel : RegisterStep3ViewModel!
    
    var email : String!
    var password: String!
    var rePassword: String!
    var accountType: String!
    var currency: String!
    var fullname: String!
    var birthday: String!
    
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
        step3ViewModel = RegisterStep3ViewModel()
    }

    func initPhoneNumberTextField() {
        phoneNumberTextField.withPrefix = true
        phoneNumberTextField.withFlag = true
        phoneNumberTextField.withExamplePlaceholder = true
        phoneNumberTextField.font = UIFont(name: Utility.appFont.semiBold, size: 15)
        phoneNumberTextField.textColor = UIColor.appBlueColor
    }

    func initCountries() {
        guard let countries = allCountry?.country, !countries.isEmpty else {return}
        self.allCountry?.country.forEach({ (country) in
            self.countryMenu.dropDownMenu.dataSource.append(country.name)
        })
        self.countryMenu.textLabel.text = countryMenu.dropDownMenu.dataSource[0]
        selectedCountry = countryMenu.dropDownMenu.dataSource[0]
        onSelectCountryDropDownMenu()
    }

    func initPrimaryIndustryList() {
        guard let list = primaryList?.primary, !list.isEmpty else {return}
        list.forEach { (title) in
            industryMenu.dropDownMenu.dataSource.append(title)
        }
        industryMenu.textLabel.text = industryMenu.dropDownMenu.dataSource[0]
        selectedPrimaryIndustry = industryMenu.dropDownMenu.dataSource[0]
        onSelectPrimaryIndustryDropDownMenu()
    }

    func initIntrested() {
        interestedMenu.dropDownMenu.dataSource = ["Buying", "Selling"]
        interestedMenu.textLabel.text = interestedMenu.dropDownMenu.dataSource[0]
        selectedInterested = interestedMenu.dropDownMenu.dataSource[0]
        onSelectedInterestedDropDownMenu()
    }
    
    func goToNextVC() {
        self.navigationController?.pushViewController(AppStoryboard.Register.viewController(viewControllerClass: RegisterCheckEmailViewController.self), animated: true)
    }
    
    func showError(error: ErrorMessageModel) {
        switch error.code {
        case 2000:
            prepareViewForError(view: phoneNumberVIew)
            break
        case 2001:
            prepareViewForError(view: addressLine1TF)
            break
        case 2002:
            prepareViewForError(view: cityTF)
            break
        case 2003:
            prepareViewForError(view: stateTF)
            break
        case 2004:
            prepareViewForError(view: zipTF)
            break
        default:
            break
        }
    }
    
    func prepareViewForError(view: UIView) {
        view.borderColor = .red
        view.becomeFirstResponder()
    }
    
    fileprivate func returnToDefaultView() {
        [phoneNumberVIew, addressLine1TF, cityTF, stateTF, zipTF].forEach { (view) in
            view?.borderColor = UIColor.appBorderColor
        }
    }
    
//MARK:- Api call
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
    
    func sendRegisterData() {
        Utility.showHudLoading()
        step3ViewModel.register(email: email, password: password, rePassword: rePassword, accountType: accountType.lowercased(), currency: currency, fullName: fullname, birthday: birthday, country: selectedCountry, mobile: phoneNumberTextField.text, addressOne: addressLine1TF.text, addressTwo: addressLine2TF.text ?? "", city: cityTF.text, state: stateTF.text, zip: zipTF.text, interested: selectedInterested.lowercased(), primary: selectedPrimaryIndustry.lowercased()) { (token, error) in
            if error == nil {
                Utility.hideSuccessHudLoading()
                self.goToNextVC()
            } else {
                Utility.hideHudLoading()
                self.showError(error: error!)
                self.showActionSheet(title: "error".getString(), message: error?.message ?? "", style: .alert, actions: [self.actionMessageClose()])
            }
        }
    }

//MARK:- Actions
    @objc fileprivate func onTapNextButton(_ sender: UITapGestureRecognizer) {
        returnToDefaultView()
        sendRegisterData()
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
            selectedInterested = item
        }
    }

}
