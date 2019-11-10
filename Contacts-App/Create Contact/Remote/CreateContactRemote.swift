//
//  CreateContactRemote.swift
//  Contacts-App
//
//  Created by Anand Nimje on 10/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation
import Alamofire

class CreateContactRemote: CreateContactRemoteDataInputProtocol {
    var remoteRequestHandler: CreateContactRemoteDataOutputProtocol?
    
    func createContact(for details: [String : Any]) {
        let headers: HTTPHeaders = [
             "Content-Type": "application/json"
         ]
         let urlPath = Endpoints.contactList.fetch.url
        
         AF.request(urlPath,
                    method: .post,
                    parameters: details,
                    encoding: JSONEncoding.default,
                    headers: headers)
             .validate()
             .responseJSON { response in
                     switch response.result {
                     case .success(let value):
                         self.remoteRequestHandler?.onSuccessfullyCreated(value as? [String: Any] ?? [:])
                     case .failure(let error):
                         debugPrint(error)
                         self.remoteRequestHandler?.onError()
                     }
         }
    }
}
