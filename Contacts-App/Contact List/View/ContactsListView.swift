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
    var presenter: ContactListPresenterProtocol?
    var contactList: ContactList = []
    let loadingViewController = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
    }
    
    func viewSetup(){
        presenter?.viewDidLoad()
        tableContactList.tableFooterView = UIView()
    }
}

extension ContactsListView: ContactListViewProtocol {
    
    func showContacts(with contacts: ContactList){
        contactList = contacts
        tableContactList.reloadData()
    }
    
    func showError() {
        //"Internet not connected"
    }
    
    func showLoading() {
       add(loadingViewController)
    }
    
    func hideLoading() {
        loadingViewController.remove()
    }
    
}
