//
//  ManageAccount.swift
//  ClearAsset
//
//  Created by Peyk Office on 14/12/2020.
//

import UIKit

class ManageAccount: UITableViewCell {

    @IBOutlet weak var bottomView: UIView!{
        didSet {
            bottomView.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
