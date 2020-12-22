//
//  BottomTableViewCell.swift
//  ClearAsset
//
//  Created by MohammadReza on 12/22/20.
//

import UIKit

class BottomTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var allItemButton: UIButton!

    let bottomCollectionIdentifier = "bottomCollectionIdentifier"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout, forRow row: Int) {
        collectionView.register(UINib(nibName: "BottomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: bottomCollectionIdentifier)
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate        
        collectionView.tag = row
        collectionView.reloadData()
    }
    
    @IBAction func didTapOnAllItemButton(_ sender: Any) {
        
    }
}
