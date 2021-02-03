//
//  SelectCategoryTableViewCell.swift
//  ClearAsset
//
//  Created by Peyk Office on 29/12/2020.
//

import UIKit

class SelectCategoryTableViewCell: UITableViewCell {
        
    @IBOutlet weak var categoryimage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
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
