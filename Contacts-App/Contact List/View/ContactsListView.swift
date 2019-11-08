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
    let imageProvider = ImageProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
    }
    
    func viewSetup(){
        tableContactList.register(UINib(nibName: "ContactListCell",
                                        bundle: nil),
                                  forCellReuseIdentifier: "ContactListCell")
        tableContactList.estimatedRowHeight = 64.0
        tableContactList.rowHeight = UITableView.automaticDimension
        tableContactList.tableFooterView = UIView()
        presenter?.viewDidLoad()
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


extension ContactsListView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell") as? ContactListCell else {
            debugPrint("Cell Identifier not found!")
            return UITableViewCell()
        }
        
        let contact = contactList[indexPath.row]
        cell.nameLable.text = contact.fullName()
        cell.favoriteImageView.image =  contact.favorite ? #imageLiteral(resourceName: "home_favourite") : nil
        
        guard let mediaUrl = NSURL(string: Endpoints.ImagePath.profilePic(contact.profilePic).url) else {
            return cell
        }
        let image = imageProvider.cache.object(forKey: mediaUrl)
        cell.profileImageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cell.profileImageView.image = image
        if image == nil {
            imageProvider.loadImages(from :mediaUrl, completion: { image  in
                let indexPath_ = self.tableContactList.indexPath(for: cell)
                if indexPath == indexPath_ {
                    cell.profileImageView.image = image
                }
            })
        }
        return cell
    }
    
}

extension ContactsListView: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        presenter?.showContactDetail(forContact: contactList[indexPath.row])
    }
}
