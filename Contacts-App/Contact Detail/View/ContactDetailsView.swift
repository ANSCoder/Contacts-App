//
//  ContactDetailsView.swift
//  Contacts-App
//
//  Created by Anand Nimje on 06/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class ContactDetailsView: UIViewController {
    
    var presenter: ContactDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension ContactDetailsView: ContactDetailViewProtocol {
    
    func showContactDetail(forContact contact: ContactModel) {
        
    }

}

