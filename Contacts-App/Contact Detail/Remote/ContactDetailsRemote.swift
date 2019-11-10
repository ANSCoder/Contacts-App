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
    
    func makeContactFavourite(for contactId: String, details: [String : Any]) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let urlPath = Endpoints.contactDetail.fetch(contactId).url
       
        AF.request(urlPath,
                   method: .put,
                   parameters: details,
                   encoding: JSONEncoding.default,
                   headers: headers)
            .validate()
            .responseDecodable {[weak self] (response: DataResponse<ContactDetailModel, AFError>) in
                    switch response.result {
                    case .success(let value):
                        self?.remoteRequestHandler?.contactAddedToFavourite(value)
                    case .failure( _):
                        self?.remoteRequestHandler?.onError()
                    }
        }
    }
}
