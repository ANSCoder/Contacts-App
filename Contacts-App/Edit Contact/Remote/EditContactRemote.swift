//
//  EditContactRemote.swift
//  Contacts-App
//
//  Created by Anand Nimje on 09/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation

class EditContactRemote: EditContactRemoteDataInputProtocol{
    var remoteRequestHandler: EditContactRemoteDataOutputProtocol?

    func updateContactDetails(for contactId: String, details: [String : Any]) {
        
    }
}
