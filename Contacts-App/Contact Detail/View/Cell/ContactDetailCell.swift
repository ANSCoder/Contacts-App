//
//  ContactDetailCell.swift
//  Contacts-App
//
//  Created by Anand Nimje on 08/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class ContactDetailCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
