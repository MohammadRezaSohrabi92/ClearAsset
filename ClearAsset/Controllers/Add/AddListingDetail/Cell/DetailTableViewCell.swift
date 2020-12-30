//
//  DetailTableViewCell.swift
//  ClearAsset
//
//  Created by Peyk Office on 29/12/2020.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let addDetailCVidentifier = "transmissionDetailCollectionViewIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forCell cell: Int) {
        collectionView.register(UINib(nibName: "AddTransmissionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: addDetailCVidentifier)
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = cell
        collectionView.reloadData()
    }
    
}
