//
//  ProductListTableViewCell.swift
//  ClearAsset
//
//  Created by Peyk Office on 03/01/2021.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
