//
//  CreateContactInteractor.swift
//  Contacts-App
//
//  Created by Anand Nimje on 10/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation

class CreateContactInteractor: CreateContactInteractorInputProtocol {
    var presenter: CreateContactInteractorOutputProtocol?
    
    var remoteDatamanager: CreateContactRemoteDataInputProtocol?
    
    func createContact(for details: [String : Any]) {
        remoteDatamanager?.createContact(for: details)
    }
    
}

extension CreateContactInteractor: CreateContactRemoteDataOutputProtocol{
    func onSuccessfullyCreated(_ contacts: [String : Any]) {
        presenter?.didCreatedNewContact(contacts)
    }
    
    func onError() {
        presenter?.onError()
    }
}
