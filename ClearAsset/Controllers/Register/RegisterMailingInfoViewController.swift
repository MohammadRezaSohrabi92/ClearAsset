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
    
    // MARK:- init var
    let countryMenu = DropDown()
    let interestedMenu = DropDown()
    let industryMenu = DropDown()
    
    // MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    // MARK:- other methods
    fileprivate func initView() {
        let dataSource = ["Car", "Motorcycle", "Truck"]
        countryMenu.anchorView = countryView
        interestedMenu.anchorView = interestedView
        industryMenu.anchorView = industryView
        let views = [countryView, interestedView, industryView]
        views.forEach { (view) in
            view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnMenu(_:))))
        }
        countryView.tag = 1
        interestedView.tag = 2
        industryView.tag = 3
        countryMenu.dataSource = dataSource
        interestedMenu.dataSource = dataSource
        industryMenu.dataSource = dataSource
    }
    
    @objc fileprivate func didTapOnMenu(_ sender: UITapGestureRecognizer) {
        switch sender.view?.tag {
        case 1:
            countryMenu.show()
            break
        case 2:
            interestedMenu.show()
            break
        case 3:
            industryMenu.show()
            break
        default:
            break
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
