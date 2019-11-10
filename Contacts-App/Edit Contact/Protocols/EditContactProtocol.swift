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
    
    func onSuccessfullyUpdated(_ contacts: [String: Any])
}

protocol EditContactWireFrameProtocol: class {
    static func editContactDetail(forContact contact: ContactDetailModel) -> UIViewController
}

protocol EditContactPresenterProtocol: class {
    var view: EditContactViewProtocol? { get set }
    var interactor: EditContactInteractorInputProtocol? { get set }
    var wireFrame: EditContactWireFrameProtocol? { get set }
    var contact: ContactDetailModel? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func updateContactDetails(for contactId: String, details: [String: Any])
}

protocol EditContactInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didSubmittedContactDetails(_ result: [String: Any])
    func onError()
}

protocol EditContactInteractorInputProtocol: class {
    var presenter: EditContactInteractorOutputProtocol? { get set }
    var remoteDatamanager: EditContactRemoteDataInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func updateContactDetails(for contactId: String, details: [String: Any])
}

protocol EditContactRemoteDataInputProtocol: class  {
    var remoteRequestHandler: EditContactRemoteDataOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func updateContactDetails(for contactId: String, details: [String: Any])
}

protocol EditContactRemoteDataOutputProtocol: class  {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onSuccessfullyUpdated(_ contacts: [String: Any])
    func onError()
}

