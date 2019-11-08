//
//  ContactListProtocols.swift
//  Contacts-App
//
//  Created by Anand Nimje on 08/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

protocol ContactListViewProtocol: class {
    var presenter: ContactListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showContacts(with contacts: ContactList)
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol ContactListWireFrameProtocol: class {
    static func createContactListModule() -> UIViewController
    // PRESENTER -> WIREFRAME
    func presentContactDetailScreen(from view: ContactListViewProtocol,
                                    forContact contact: ContactModel)
}

protocol ContactListPresenterProtocol: class {
    var view: ContactListViewProtocol? { get set }
    var interactor: ContactListInteractorInputProtocol? { get set }
    var wireFrame: ContactListWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showContactDetail(forContact contact: ContactModel)
}

protocol ContactListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveContacts(_ contacts: ContactList)
    func onError()
}

protocol ContactListInteractorInputProtocol: class {
    var presenter: ContactListInteractorOutputProtocol? { get set }
    var remoteDatamanager: ContactListRemoteDataInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveContactList()
}

protocol ContactListDataInputProtocol: class  {
    // INTERACTOR -> DATAMANAGER
}

protocol ContactListRemoteDataInputProtocol: class  {
    var remoteRequestHandler: ContactListRemoteDataOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func fetchContactList()
}

protocol ContactListRemoteDataOutputProtocol: class  {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onContactsRetrieved(_ contacts: ContactList)
    func onError()
}


