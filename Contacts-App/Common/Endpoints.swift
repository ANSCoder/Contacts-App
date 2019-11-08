//
//  Endpoints.swift
//  Contacts-App
//
//  Created by Anand Nimje on 08/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation

struct API {
    static let baseUrl = "http://gojek-contacts-app.herokuapp.com"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum ImagePath: Endpoint{
        
        case profilePic(String)
        
        public var path: String {
            switch self {
            case .profilePic(let name): return name
            }
        }
        
        public var url: String {
            switch self {
            case .profilePic: return "\(API.baseUrl)\(path)"
            }
        }
    }
    
    enum contactList: Endpoint {
        case fetch
        
        public var path: String {
            switch self {
            case .fetch: return "/contacts.json"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)"
            }
        }
    }
    
    enum contactDetail: Endpoint {
        case fetch(_ contactId: String)
        
        public var path: String {
            switch self {
            case .fetch(let id): return "/contacts/\(id).json"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)"
            }
        }
    }
}
