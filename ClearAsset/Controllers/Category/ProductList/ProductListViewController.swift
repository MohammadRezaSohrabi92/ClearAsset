//
//  FilterViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 02/01/2021.
//

import UIKit

class ProductListViewController: BaseViewController {
    
//MARK:- Views
    @IBOutlet weak var filterButton: UIView!
    
    
//init var
    
    
//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    
//MARK:- Other Methods
    func initView() {
        filterButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnFilter(_:))))
    }
    
//MARK:- Actions
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapOnFilter(_ sender: UITapGestureRecognizer) {
        let filterVC = AppStoryboard.Filter.viewController(viewControllerClass: FilterViewController.self)
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    
}

//MARK:- TableView Delegate and Data Source

