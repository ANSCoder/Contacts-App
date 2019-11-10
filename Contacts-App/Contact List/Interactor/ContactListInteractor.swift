//
//  ContactListInteractor.swift
//  Contacts-App
//
//  Created by Anand Nimje on 08/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation


class ContactListInteractor: ContactListInteractorInputProtocol {
    
    weak var presenter: ContactListInteractorOutputProtocol?
    var remoteDatamanager: ContactListRemoteDataInputProtocol?
    
    func retrieveContactList() {
        remoteDatamanager?.fetchContactList()
    }
    
    func deleteContact(for contactId: String) {
        remoteDatamanager?.proceedDeleteContact(for: contactId)
    }
}

extension ContactListInteractor: ContactListRemoteDataOutputProtocol {
    
    func onDeleteContactSuccessFully() {
        presenter?.didContactDeleteSuccessfully()
    }
    
    func onContactsRetrieved(_ contacts: ContactList) {
        presenter?.didRetrieveContacts(contacts)
    }
    
    func onError() {
        presenter?.onError()
    }
    
}
