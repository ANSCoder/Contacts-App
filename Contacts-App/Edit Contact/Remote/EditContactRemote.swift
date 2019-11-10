//
//  EditContactRemote.swift
//  Contacts-App
//
//  Created by Anand Nimje on 09/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation
import Alamofire

class EditContactRemote: EditContactRemoteDataInputProtocol{
    var remoteRequestHandler: EditContactRemoteDataOutputProtocol?
    
    func updateContactDetails(for contactId: String, details: [String : Any]) {
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
            .responseJSON {[weak self] response in
                    switch response.result {
                    case .success(let value):
                        self?.remoteRequestHandler?.onSuccessfullyUpdated(value as? [String: Any] ?? [:])
                    case .failure( _):
                        self?.remoteRequestHandler?.onError()
                    }
        }
    }
}
