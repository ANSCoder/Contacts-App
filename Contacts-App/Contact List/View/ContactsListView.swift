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
    
    //MARK : - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
    }
    
    //MARK: - Setup for the Table View
    func viewSetup(){
        tableContactList.register(UINib(nibName: "ContactListCell",
                                        bundle: nil),
                                  forCellReuseIdentifier: "ContactListCell")
        tableContactList.estimatedRowHeight = 64.0
        tableContactList.rowHeight = UITableView.automaticDimension
        tableContactList.tableFooterView = UIView()
        addObserver()
    }
    
    func addObserver(){
        NotificationCenter
            .default
            .addObserver(forName: .refreshHomeView,
                         object: nil,
                         queue: nil) { [weak self] _ in
                            self?.presenter?.viewDidLoad()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
    }
    
    //MARK: - Update Contact Details
    @IBAction func createNewContact(_ sender: UIBarButtonItem) {
        presenter?.createNewContact()
    }
    
    //MARK: - Make group list
    @IBAction func createGroup(_ sender: UIBarButtonItem) {
        guard contactList.count != 0 else {
            return
        }
        let group = Dictionary(grouping: contactList) {
            $0[keyPath: \.firstName].prefix(1).uppercased()
        }.sorted{ $0.key < $1.key }
        print(group)
    }
}

//MARK: - Networking API response & Data setup for View
extension ContactsListView: ContactListViewProtocol {
    
    func contactDeletedSuccessfully() {
        //Refresh view data
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.viewDidLoad()
        }
    }
    
    func showContacts(with contacts: ContactList){
        contactList = contacts
        tableContactList.reloadData()
    }
    
    func showError() {
        showAleartViewwithTitle("Error!", message: "Something went wrong!")
    }
    
    func showLoading() {
        add(loadingViewController)
    }
    
    func hideLoading() {
        loadingViewController.remove()
    }
}


//MARK: - Table View DataSource
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
            imageProvider.loadImages(from :mediaUrl, completion: {[weak self] image  in
                let indexPath_ = self?.tableContactList.indexPath(for: cell)
                if indexPath == indexPath_ {
                    cell.profileImageView.image = image
                }
            })
        }
        return cell
    }
    
}

//MARK: - TableView Delegate Methods
extension ContactsListView: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        presenter?.showContactDetail(forContact: contactList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            presenter?.requestForDelete(String(contactList[indexPath.row].id))
        }
    }
}
