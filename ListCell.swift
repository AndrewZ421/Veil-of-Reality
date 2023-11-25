//
//  ListCell.swift
//  Veil-of-Reality
//
//  Created by 曾七七 on 11/25/23.
//

import UIKit

class ListCell: UITableViewCell {
    
    

    @IBOutlet weak var listImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var salaryLabel: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
