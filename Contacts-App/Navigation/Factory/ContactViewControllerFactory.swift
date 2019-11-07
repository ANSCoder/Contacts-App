//
//  ContactViewControllerFactory.swift
//  Contacts-App
//
//  Created by Anand Nimje on 07/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

struct ContactViewControllerFactory {
    
    func makeContactDetailsViewController()-> ContactDetailsView{
        return ContactDetailsView.instantiate()
    }
    
    func makeEditContactViewController()-> EditContactView{
        return EditContactView.instantiate()
    }
    
}

