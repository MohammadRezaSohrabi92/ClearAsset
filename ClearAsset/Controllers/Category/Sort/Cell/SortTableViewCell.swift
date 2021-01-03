//
//  SortTableViewCell.swift
//  ClearAsset
//
//  Created by Peyk Office on 03/01/2021.
//

import UIKit

class SortTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
