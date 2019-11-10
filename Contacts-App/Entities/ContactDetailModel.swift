//
//  ContactDetailModel.swift
//  Contacts-App
//
//  Created by Anand Nimje on 08/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation

// MARK: - ContactDetailModel
struct ContactDetailModel: Codable {
    let id: Int
    let firstName, lastName, email, phoneNumber: String
    let profilePic: String
    var favorite: Bool
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case phoneNumber = "phone_number"
        case profilePic = "profile_pic"
        case favorite
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    func fullName() -> String{
        return firstName.capitalizingFirstLetter() + " " + lastName.capitalizingFirstLetter()
    }
}

typealias ContactDetailList = [ContactDetailModel]
