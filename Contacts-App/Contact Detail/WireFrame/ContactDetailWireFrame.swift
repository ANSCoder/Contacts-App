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
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ContactDetailsView")
        if let view = viewController as? ContactDetailsView {
            let presenter: ContactDetailPresenterProtocol & ContactDetailsInteractorOutputProtocol = ContactDetailPresenter()
            let interactor: ContactDetailsInteractorInputProtocol & ContactDetailsRemoteDataOutputProtocol = ContactDetailsInteractor()
            let remoteDataManager: ContactDetailsRemoteDataInputProtocol = ContactDetailsRemote()
            let wireFrame: ContactDetailWireFrameProtocol = ContactDetailWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.contact = contact
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func presentEditContactScreen(from view: ContactDetailViewProtocol,
                                    forContact contact: ContactDetailModel){
        let contactDetailViewController = EditContactWireFrame.editContactDetail(forContact: contact)
        
        if let sourceView = view as? UIViewController {
            let navController = UINavigationController(rootViewController: contactDetailViewController)
            navController.navigationBar.tintColor = .lightGray
            sourceView.navigationController?.present(navController,
                                                     animated: true, completion: nil)
        }
    }
}

