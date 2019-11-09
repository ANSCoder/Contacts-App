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
        
    }
}

extension EditContactIntractor: EditContactRemoteDataOutputProtocol{
    func onSuccessfullyUpdated(_ contacts: ContactDetailModel) {
        
    }
    
    func onError() {
        presenter?.onError()
    }
}
