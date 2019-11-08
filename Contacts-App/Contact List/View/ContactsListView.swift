//
//  ContactsListView.swift
//  Contacts-App
//
//  Created by Anand Nimje on 06/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class ContactsListView: UIViewController {
    
    @IBOutlet weak var tableContactList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let navigator = ContactNavigator(navigationController: view.window?.rootViewController as! UINavigationController,
                       viewControllerFactory: ContactViewControllerFactory())
        navigator.navigate(to: .editContact)
    }
    
    func viewSetup(){
        
    }
}
