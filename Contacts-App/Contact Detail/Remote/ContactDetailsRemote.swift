//
//  ContactDetailsRemote.swift
//  Contacts-App
//
//  Created by Anand Nimje on 08/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation
import Alamofire

class ContactDetailsRemote: ContactDetailsRemoteDataInputProtocol {
    var remoteRequestHandler: ContactDetailsRemoteDataOutputProtocol?
    
    func fetchContactDetails(for contactId: String) {
            AF
            .request(Endpoints.contactDetail.fetch(contactId).url, method: .get)
            .validate()
            .responseDecodable { (response: DataResponse<ContactDetailModel, AFError>) in
                switch response.result {
                case .success(let details):
                    self.remoteRequestHandler?.onContactDetailsRetrieved(details)
                case .failure( _):
                    self.remoteRequestHandler?.onError()
                }
        }
    }
}
