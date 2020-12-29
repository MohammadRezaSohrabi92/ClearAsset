//
//  AddListingDetailViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 27/12/2020.
//

import UIKit

class AddListingDetailViewController: UIViewController {
    
    //MARK:- Views
    @IBOutlet weak var transmissionDetailCV: UICollectionView!
    @IBOutlet weak var mainTable: UITableView!
        
    //init var
    let transmissionDetailCVIdentifier = "transmissionDetailCollectionViewIdentifier"

    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    //MARK:- Other Methods
    func initViews() {
        transmissionDetailCV.register(UINib(nibName: "AddTransmissionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: transmissionDetailCVIdentifier)
    }
    
}

    //MARK:- CollectionView Delegate and Data Source
extension AddListingDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let item = collectionView.dequeueReusableCell(withReuseIdentifier: transmissionDetailCVIdentifier, for: indexPath) as? AddTransmissionCollectionViewCell {
            return item
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
}
