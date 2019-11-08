//
//  ContactDetailWireFrame.swift
//  Contacts-App
//
//  Created by Anand Nimje on 08/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class ContactDetailWireFrame: ContactDetailWireFrameProtocol {
    
    class func createContactDetailModule(forContact contact: ContactModel) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "PostDetailController")
        if let view = viewController as? ContactDetailsView {
            let presenter: ContactDetailPresenterProtocol = ContactDetailPresenter()
            let wireFrame: ContactDetailWireFrameProtocol = ContactDetailWireFrame()
            
            view.presenter = presenter
           // presenter.view = view
            presenter.contact = contact
            presenter.wireFrame = wireFrame
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}

