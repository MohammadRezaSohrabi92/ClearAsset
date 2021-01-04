//
//  ServicePreviewTableViewCell.swift
//  ClearAsset
//
//  Created by Peyk Office on 27/12/2020.
//

import UIKit

class ServicePreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var forwardButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }    
    
    @IBAction func didTapOnForwardButton(_ sender: Any) {
        
    }
}
