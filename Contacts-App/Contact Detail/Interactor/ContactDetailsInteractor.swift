//
//  ContactDetailsInteractor.swift
//  Contacts-App
//
//  Created by Anand Nimje on 08/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//
 
import Foundation

class ContactDetailsInteractor: ContactDetailsInteractorInputProtocol {
    
    var presenter: ContactDetailsInteractorOutputProtocol?
    
    var remoteDatamanager: ContactDetailsRemoteDataInputProtocol?
    
    func retrieveContactDetails(for contactId: String) {
        remoteDatamanager?.fetchContactDetails(for: contactId)
    }
}

extension ContactDetailsInteractor: ContactDetailsRemoteDataOutputProtocol{
    
    func onContactDetailsRetrieved(_ contacts: ContactDetailModel) {
        presenter?.didRetrieveContacts(contacts)
    }
    
    func onError() {
        presenter?.onError()
    }
}
