//
//  EditContactProtocol.swift
//  Contacts-App
//
//  Created by Anand Nimje on 09/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

protocol EditContactViewProtocol: class {
    var presenter: EditContactPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showContactDetail(forContact details: ContactDetailModel)
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol EditContactWireFrameProtocol: class {
    static func editContactDetail(forContact contact: ContactDetailModel) -> UIViewController
}

protocol EditContactPresenterProtocol: class {
    var view: ContactDetailViewProtocol? { get set }
    var interactor: ContactDetailsInteractorInputProtocol? { get set }
    var wireFrame: ContactDetailWireFrameProtocol? { get set }
    var contact: ContactDetailModel? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol EditContactInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didSubmittedContactDetails(_ result: Any)
    func onError()
}

protocol EditContactInteractorInputProtocol: class {
    var presenter: ContactDetailsInteractorOutputProtocol? { get set }
    var remoteDatamanager: ContactDetailsRemoteDataInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func updateContactDetails(for details: [String: Any])
}

protocol EditContactRemoteDataInputProtocol: class  {
    var remoteRequestHandler: ContactDetailsRemoteDataOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func updateContactDetails(for contactId: String)
}

protocol EditContactRemoteDataOutputProtocol: class  {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onSuccessfullyUpdated(_ contacts: ContactDetailModel)
    func onError()
}

