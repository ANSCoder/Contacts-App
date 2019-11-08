//
//  ContactListRemote.swift
//  Contacts-App
//
//  Created by Anand Nimje on 08/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation
import Alamofire

class ContactListRemote: ContactListRemoteDataInputProtocol{
    
    var remoteRequestHandler: ContactListRemoteDataOutputProtocol?
    
    func fetchContactList() {
           AF
            .request(Endpoints.contactList.fetch.url, method: .get)
            .validate()
            .responseDecodable { (response: DataResponse<ContactList, AFError>) in
                switch response.result {
                case .success(let contacts):
                    self.remoteRequestHandler?.onContactsRetrieved(contacts)
                case .failure( _):
                    self.remoteRequestHandler?.onError()
                }
        }
    }
}
