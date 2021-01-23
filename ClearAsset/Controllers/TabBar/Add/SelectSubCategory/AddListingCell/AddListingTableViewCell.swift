//
//  AddListingTableViewCell.swift
//  ClearAsset
//
//  Created by Peyk Office on 26/12/2020.
//

import UIKit

class AddListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subCategoryImageVIew: UIImageView!
    @IBOutlet weak var subCategoryTitle: UILabel!
    
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
