//
//  ExNotificationCenter.swift
//  Contacts-App
//
//  Created by Anand Nimje on 10/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var refreshDetailsView: Notification.Name {
        return .init(rawValue: "com.update.details.view")
    }
    
    static var refreshHomeView: Notification.Name {
        return .init(rawValue: "com.update.home.view")
    }
}
