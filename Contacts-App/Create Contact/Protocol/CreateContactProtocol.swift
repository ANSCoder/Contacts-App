//
//  CreateContactProtocol.swift
//  Contacts-App
//
//  Created by Anand Nimje on 10/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

protocol CreateContactViewProtocol: class {
    var presenter: CreateContactPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showError()
    
    func showLoading()
    
    func hideLoading()
    
    func onSuccessfullyCreate(_ contacts: [String: Any])
}

protocol CreateContactWireFrameProtocol: class {
    static func creatNewContactView() -> UIViewController
}

protocol CreateContactPresenterProtocol: class {
    var view: CreateContactViewProtocol? { get set }
    var interactor: CreateContactInteractorInputProtocol? { get set }
    var wireFrame: CreateContactWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func createContact(for details: [String: Any])
}

protocol CreateContactInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didSubmittedContactDetails(_ result: [String: Any])
    func onError()
}

protocol CreateContactInteractorInputProtocol: class {
    var presenter: CreateContactInteractorOutputProtocol? { get set }
    var remoteDatamanager: CreateContactRemoteDataInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func createContact(for contactId: String, details: [String: Any])
}

protocol CreateContactRemoteDataInputProtocol: class  {
    var remoteRequestHandler: CreateContactRemoteDataOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func createContact(for details: [String: Any])
}

protocol CreateContactRemoteDataOutputProtocol: class  {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onSuccessfullyCreated(_ contacts: [String: Any])
    func onError()
}


