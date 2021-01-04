//
//  MiddleTableViewCell.swift
//  ClearAsset
//
//  Created by MohammadReza on 12/22/20.
//

import UIKit

class MiddleTableViewCell: UITableViewCell {    

    @IBOutlet weak var collectionView: UICollectionView!

    let middleCollectionIdentifier = "middleCollectionIdentifer"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forSection section: Int) {
        collectionView.register(UINib(nibName: "MiddleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: middleCollectionIdentifier)
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = section
        collectionView.reloadData()
    }
    
}
