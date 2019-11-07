//
//  Navigator.swift
//  Contacts-App
//
//  Created by Anand Nimje on 07/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation

protocol Navigator {
    associatedtype Destination

    func navigate(to destination: Destination)
}
