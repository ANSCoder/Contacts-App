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
    func showContactDetail(forContact details: ContactDetailModel)
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol ContactDetailWireFrameProtocol: class {
    static func createContactDetailModule(forContact contact: ContactModel) -> UIViewController
}

protocol ContactDetailPresenterProtocol: class {
    var view: ContactDetailViewProtocol? { get set }
    var interactor: ContactDetailsInteractorInputProtocol? { get set }
    var wireFrame: ContactDetailWireFrameProtocol? { get set }
    var contact: ContactModel? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol ContactDetailsInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveContacts(_ contacts: ContactDetailModel)
    func onError()
}

protocol ContactDetailsInteractorInputProtocol: class {
    var presenter: ContactDetailsInteractorOutputProtocol? { get set }
    var remoteDatamanager: ContactDetailsRemoteDataInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveContactList(for contactId: String)
}

protocol ContactDetailsRemoteDataInputProtocol: class  {
    var remoteRequestHandler: ContactDetailsRemoteDataOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func fetchContactDetails(for contactId: String)
}

protocol ContactDetailsRemoteDataOutputProtocol: class  {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onContactDetailsRetrieved(_ contacts: ContactDetailModel)
    func onError()
}
