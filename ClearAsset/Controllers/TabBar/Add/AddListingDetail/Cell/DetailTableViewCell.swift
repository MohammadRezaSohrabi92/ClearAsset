//
//  DetailTableViewCell.swift
//  ClearAsset
//
//  Created by Peyk Office on 29/12/2020.
//

import UIKit

protocol DeleteDetailRow {
    func didTapOnDeleteButton(cell: DetailTableViewCell)
    func didTapOnAddButton(cell: DetailTableViewCell)
}

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var mainTitleLabel: CustomAddTitle!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleTF: CustomAddTextFeild!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var addImageButtonView: UIView!
    @IBOutlet weak var deleteImageView: UIView!
    
    let addDetailCVidentifier = "transmissionDetailCollectionViewIdentifier"
    var delegate: DeleteDetailRow?
    var imageItems = [UIImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        initViews()
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
    
    func initViews() {
        deleteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnDeleteButton(_:))))
        addImageButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnAddImage(_:))))
    }
    
    @objc func didTapOnDeleteButton(_ sender: UITapGestureRecognizer) {
        delegate?.didTapOnDeleteButton(cell: self)
    }
    
    @objc func didTapOnAddImage(_ sender: UITapGestureRecognizer) {
        delegate?.didTapOnAddButton(cell: self)
    }
    
}
