//
//  RegisterAboutYourselfViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 12/12/2020.
//

import UIKit

class RegisterAboutYourselfViewController: BaseViewController {
    
    //MARK:- views
    @IBOutlet private var nextButton: CustomButton!    
    @IBOutlet weak var accountType: CustomDropDownMenu!
    @IBOutlet weak var currencyType: CustomDropDownMenu!
    @IBOutlet weak var name: CustomTextField!
    @IBOutlet weak var selectBirthdate: UIView!
    @IBOutlet weak var lbSelectBirthdate: CustomLabel!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    //init var
    let datePicker = UIDatePicker()
    var currencyViewModel: GetCurrencyViewModel!
    var currencyData: currencyData?
    var step2ViewModel: RegisterStep2ViewModel!
    
    var selectedAccountType = ""
    var selectedPreferredCurrency = ""

    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
        getCurrencyList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //code
    }
    
    //MARK:- other methods
    fileprivate func initView() {
        initScrollView(mainScrollView)
        initAccountType()
        nextButton.setOnClick(onClick: #selector(onTapNextButton(_:)))
        createCustomDatePicker()
        selectBirthdate.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnBirthdatePicker)))
        currencyViewModel = GetCurrencyViewModel()
        step2ViewModel = RegisterStep2ViewModel()
    }
    
    fileprivate func initAccountType() {
        accountType.dropDownMenu.dataSource = ["personal".getString(), "business".getString()]
        accountType.textLabel.text = accountType.dropDownMenu.dataSource[0]
        onSelectAccountTypeDropDownMenu()
        selectedAccountType = accountType.dropDownMenu.dataSource[0]
        
    }
    
    fileprivate func initPreferredCurrency(allCurrency: currencyData) {
        let currency = allCurrency.data.currency
        currency?.forEach({ (value) in
            currencyType.dropDownMenu.dataSource.append(value.name!)
        })
        if currencyType.dropDownMenu.dataSource.isEmpty {
            return
        }
        currencyType.textLabel.text = currencyType.dropDownMenu.dataSource[0]
        selectedPreferredCurrency = (currencyData?.data.currency![0].value)!
        onSelectCurrencyTypeDropDownMenu()
    }
    
    fileprivate func getCurrencyList() {
        Utility.showHudLoading()
        currencyViewModel.getCurrencyList { (allCurrency, error) in
            if error == nil {
                Utility.hideHudLoading()
                self.currencyData = allCurrency
                self.initPreferredCurrency(allCurrency: self.currencyData!)
            } else {
                Utility.hideHudLoading()
                self.showActionSheet(title: "error".getString(), message: error!.localizedDescription, style: .alert, actions: [self.actionMessageClose()])
            }
        }
    }
    
    fileprivate func createCustomDatePicker() {
        datePicker.datePickerMode = .date
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.centerYAnchor.constraint(equalTo: self.selectBirthdate.centerYAnchor).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: self.selectBirthdate.leadingAnchor, constant: 12).isActive = true
        datePicker.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 1).isActive = true
        datePicker.isHidden = true
        datePicker.tintColor = UIColor.appBlueColor
    }
    
    fileprivate func goToNextPage() {
        let nextVC = AppStoryboard.Register.viewController(viewControllerClass: RegisterMailingInfoViewController.self)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
//MARK:- Actions
    func onSelectAccountTypeDropDownMenu() {
        accountType.dropDownMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            accountType.textLabel.text = item
            selectedAccountType = item
        }
    }
    
    func onSelectCurrencyTypeDropDownMenu() {
        currencyType.dropDownMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            currencyType.textLabel.text = item
            selectedPreferredCurrency = (currencyData?.data.currency![index].value)!
        }
    }
    
    @objc fileprivate func onTapNextButton(_ sender: UITapGestureRecognizer) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        Utility.showHudLoading()
        step2ViewModel.register(accountType: selectedAccountType.lowercased(), preferredCurrency: selectedPreferredCurrency, fullName: name.text, Birthday: formatter.string(from: datePicker.date)) { (topLevelError, error) in
            if error == nil {
                Utility.hideHudLoading()
                self.goToNextPage()
            } else {
                Utility.hideHudLoading()
                self.showActionSheet(title: "error".getString(), message: error!.message, style: .alert, actions: [self.actionMessageClose()])                
            }
        }

    }
    
    @objc fileprivate func didTapOnBirthdatePicker() {
        lbSelectBirthdate.isHidden = true
        datePicker.isHidden = false
    }
    
}
