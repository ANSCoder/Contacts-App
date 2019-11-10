//
//  EditContactIntractor.swift
//  Contacts-App
//
//  Created by Anand Nimje on 09/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation

class EditContactIntractor: EditContactInteractorInputProtocol{
    
    var presenter: EditContactInteractorOutputProtocol?
    
    var remoteDatamanager: EditContactRemoteDataInputProtocol?
    
    func updateContactDetails(for contactId: String, details: [String : Any]) {
        remoteDatamanager?.updateContactDetails(for: contactId,
                                                details: details)
    }
}

extension EditContactIntractor: EditContactRemoteDataOutputProtocol{
    
    func onSuccessfullyUpdated(_ contacts: [String : Any]) {
        presenter?.didSubmittedContactDetails(contacts)
    }
    
    func onError() {
        presenter?.onError()
    }
}
