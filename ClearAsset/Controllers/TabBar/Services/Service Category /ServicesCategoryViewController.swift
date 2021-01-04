//
//  ServicesViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 26/12/2020.
//

import UIKit
import SideMenu

class ServicesCategoryViewController: UIViewController {
    
    //MARK:- views
    @IBOutlet weak var mainCollection: UICollectionView!
    
    //init var
    let mainCollectionIdentifier = "serviceCategoryCollectionViewCellIdentifier"
    var menu : SideMenuNavigationController!
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
    }
    
    //MARK:- Other methods
    func initViews() {
        initMenu()
        mainCollection.register(UINib(nibName: "ServiceCategoryCVCell", bundle: nil), forCellWithReuseIdentifier: mainCollectionIdentifier)
    }
    
    func initMenu() {
        let sb = UIStoryboard(name: "Menu", bundle: nil)
        menu = sb.instantiateViewController(withIdentifier: "SideMenuNavigationController") as? SideMenuNavigationController
        menu.menuWidth = self.view.layer.frame.width - (self.view.layer.frame.width / 6)
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
    
//MARK:- actions
    
    @IBAction func didTapOnMenuButton(_ sender: Any) {
        present(menu, animated: true, completion: nil)
    }

}

//MARK:- collection view delegate and data source
extension ServicesCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let item = collectionView.dequeueReusableCell(withReuseIdentifier: mainCollectionIdentifier, for: indexPath) as? ServiceCategoryCVCell {
            return item
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(AppStoryboard.Services.viewController(viewControllerClass: ServicePreviewViewController.self), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.layer.frame.width/3, height: self.view.layer.frame.width/2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
