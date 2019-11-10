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
    
    func requestForContactAddToFavourite(for contactId: String, details: [String : Any]) {
        remoteDatamanager?.makeContactFavourite(for: contactId, details: details)
    }
}

extension ContactDetailsInteractor: ContactDetailsRemoteDataOutputProtocol{
    
    func contactAddedToFavourite(_ details: ContactDetailModel) {
        presenter?.didContactAddedToFavourite(details)
    }
    
    func onContactDetailsRetrieved(_ contacts: ContactDetailModel) {
        presenter?.didRetrieveContacts(contacts)
    }
    
    func onError() {
        presenter?.onError()
    }
}
