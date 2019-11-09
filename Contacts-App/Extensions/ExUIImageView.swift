//
//  ExUIImageView.swift
//  Contacts-App
//
//  Created by Anand Nimje on 09/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

extension UIImageView {

    func makeRounded() {
        layer.borderWidth = 1.5
        layer.masksToBounds = false
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
