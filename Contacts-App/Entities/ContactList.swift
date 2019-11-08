//
//  ContactList.swift
//  Contacts-App
//
//  Created by Anand Nimje on 08/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation

// MARK: - ContactModel
struct ContactModel: Codable {
    let id: Int
    let firstName, lastName, profilePic: String
    let favorite: Bool
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case favorite, url
    }
    
    func fullName() -> String{
        return firstName.capitalizingFirstLetter() + " " + lastName.capitalizingFirstLetter()
    }
}

typealias ContactList = [ContactModel]
