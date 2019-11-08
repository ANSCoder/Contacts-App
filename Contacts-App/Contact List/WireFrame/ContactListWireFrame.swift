//
//  ContactListWireFrame.swift
//  Contacts-App
//
//  Created by Anand Nimje on 08/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class ContactListWireFrame: ContactListWireFrameProtocol {
    
    static func createContactListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "ContactsNavigationController")
        if let view = navController.children.first as? ContactsListView {
            let presenter: ContactListPresenterProtocol & ContactListInteractorOutputProtocol = ContactListPresenter()
            let interactor: ContactListInteractorInputProtocol & ContactListRemoteDataOutputProtocol = ContactListInteractor()
            let remoteDataManager: ContactListRemoteDataInputProtocol = ContactListRemote()
            let wireFrame: ContactListWireFrameProtocol = ContactListWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func presentContactDetailScreen(from view: ContactListViewProtocol, forContact contact: ContactModel) {
        let contactDetailViewController = ContactDetailWireFrame.createContactDetailModule(forContact: contact)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(contactDetailViewController, animated: true)
        }
    }
    
    
}
