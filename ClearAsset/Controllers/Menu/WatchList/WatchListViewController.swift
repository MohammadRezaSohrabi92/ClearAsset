//
//  WatchListViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 30/12/2020.
//

import UIKit

class WatchListViewController: BaseViewController {
    
//MARK:- Views
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var btnAuction: UIView!
    @IBOutlet weak var btnTender: UIView!
    @IBOutlet weak var btnSale: UIView!
    
    //init var
    let saleTableViewCellIdentifier = "SaleTableViewCellIdentifier"
    let auctionTableViewCellIdentifier = "AuctionTableViewCellIdentifier"
    var didSale = true
    var didTender = false
    var didAuction = false
    var numberOfRows = 5
    
//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
//MARK:- Other methods
    func initView() {
        [btnAuction, btnSale, btnTender].forEach { (button) in            
            button?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnButton(_:))))
        }
        mainTable.register(UINib(nibName: "SaleTableViewCell", bundle: nil), forCellReuseIdentifier: saleTableViewCellIdentifier)
        mainTable.register(UINib(nibName: "AuctionTableViewCell", bundle: nil), forCellReuseIdentifier: auctionTableViewCellIdentifier)
    }

    
//MARK:- actions
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapOnButton(_ sender: UITapGestureRecognizer) {
        switch sender.view?.tag {
        case 1:
            //code
            if didSale { break }
            prepareViewForSelectedButton(btnSale)
            prepareDefaultViewForSelectedButton(btnAuction)
            didSale = true
            didAuction = false
            deleteAllCells()
            break
        case 2:
            //code
            break
        case 3:
            //code
            if didAuction { break }
            prepareViewForSelectedButton(btnAuction)
            prepareDefaultViewForSelectedButton(btnSale)
            didSale = false
            didAuction = true
            deleteAllCells()
            break
        default:
            break
        }
    }
    
    func deleteAllCells() {
        var indexPaths = [IndexPath]()
        for i in 0..<5 {
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        numberOfRows = 0
        mainTable.deleteRows(at: indexPaths, with: .left)
        numberOfRows = 5
        mainTable.reloadData()
    }
    
    func prepareViewForSelectedButton(_ view: UIView) {
        //view.borderColor = UIColor.orange
        view.animateBorderColor(toColor: UIColor.appOrangeColor!, duration: 0.7)
    }
    
    func prepareDefaultViewForSelectedButton(_ view: UIView) {
        view.borderColor = UIColor.appBorderColor
    }
    
}

//MARK:- TableView Delegate and DataSource
extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if didSale {
            if let cell = tableView.dequeueReusableCell(withIdentifier: saleTableViewCellIdentifier, for: indexPath) as? SaleTableViewCell {
                return cell
            }
        } else if didAuction {
            if let cell = tableView.dequeueReusableCell(withIdentifier: auctionTableViewCellIdentifier, for: indexPath) as? AuctionTableViewCell {
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}

extension UIView {
  func animateBorderColor(toColor: UIColor, duration: Double) {
    let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
    animation.fromValue = layer.borderColor
    animation.toValue = toColor.cgColor
    animation.duration = duration
    layer.add(animation, forKey: "borderColor")
    layer.borderColor = toColor.cgColor
  }
}
