//
//  ContactDetailProtocols.swift
//  Contacts-App
//
//  Created by Anand Nimje on 08/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

protocol ContactDetailViewProtocol: class {
    var presenter: ContactDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showContactDetail(forContact contact: ContactModel)
}

protocol ContactDetailWireFrameProtocol: class {
    static func createContactDetailModule(forContact contact: ContactModel) -> UIViewController
}

protocol ContactDetailPresenterProtocol: class {
    var view: ContactDetailViewProtocol? { get set }
    var wireFrame: ContactDetailWireFrameProtocol? { get set }
    var contact: ContactModel? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}
