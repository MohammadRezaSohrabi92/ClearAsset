//
//  CustomBottomSheetTableViewCell.swift
//  ClearAsset
//
//  Created by Peyk Office on 01/02/2021.
//

import UIKit

class CustomBottomSheetTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var descLabel: UILabel!
    
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
