//
//  EditContactHeaderView.swift
//  Contacts-App
//
//  Created by Anand Nimje on 09/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class EditContactHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var updateImageButton: UIButton!
    
    var subscribeButtonAction: (() -> ())?
    
    override func draw(_ rect: CGRect) {
       profileImageView.makeRounded()
       updateImageButton.addTarget(self,
                                   action: #selector(subscribeButtonTapped),
                                   for: .touchUpInside)
    }
    
    @objc func subscribeButtonTapped(){
         subscribeButtonAction?()
    }
}
