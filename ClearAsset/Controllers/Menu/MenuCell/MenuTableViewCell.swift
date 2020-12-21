//
//  MenuTableViewCell.swift
//  ClearAsset
//
//  Created by Peyk Office on 20/12/2020.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(title: String, imageName: String) {
        cellTitle.text = title
        cellImage.image = UIImage(named: imageName)
    }
    
}
