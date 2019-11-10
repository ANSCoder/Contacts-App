//
//  UpdateDetailsCell.swift
//  Contacts-App
//
//  Created by Anand Nimje on 09/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class UpdateDetailsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextField!
    var detailsTextUpdated: ((_ value: String)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailsTextView.addTarget(self,
                                  action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        detailsTextUpdated?(detailsTextView.text ?? "")
    }
    
}
