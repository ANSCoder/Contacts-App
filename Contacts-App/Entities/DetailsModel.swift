//
//  DetailsModel.swift
//  Contacts-App
//
//  Created by Anand Nimje on 09/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation

class DetailsModel {
    var title, value: String
    
    init(_ dic: [String: String]) {
        self.title = dic["title"] ?? ""
        self.value = dic["value"] ?? ""
    }
}
