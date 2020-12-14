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
    
    //init var
    let datePicker = UIDatePicker()

    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    //MARK:- other methods
    fileprivate func initView() {
        nextButton.setOnClick(onClick: #selector(onTapNextButton(_:)))
        createCustomDatePicker()
        selectBirthdate.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnBirthdatePicker)))
    }
    
    @objc fileprivate func onTapNextButton(_ sender: UITapGestureRecognizer) {
        let nextVC = AppStoryboard.Register.viewController(viewControllerClass: RegisterMailingInfoViewController.self)
        self.navigationController?.pushViewController(nextVC, animated: true)
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
    
    @objc fileprivate func didTapOnBirthdatePicker() {
        lbSelectBirthdate.isHidden = true
        datePicker.isHidden = false
    }

}
