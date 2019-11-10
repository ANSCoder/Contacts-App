//
//  ContactListPresenter.swift
//  Contacts-App
//
//  Created by Anand Nimje on 08/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation

class ContactListPresenter: ContactListPresenterProtocol {
    
    weak var view: ContactListViewProtocol?
    var interactor: ContactListInteractorInputProtocol?
    var wireFrame: ContactListWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrieveContactList()
    }
    
    //MARK: - Navigation
    func showContactDetail(forContact contact: ContactModel) {
        wireFrame?.presentContactDetailScreen(from: view!, forContact: contact)
    }
    
    func createNewContact() {
        wireFrame?.presentCreateContactScreen(from: view!)
    }
    
    func requestForDelete(_ contact: String) {
        view?.showLoading()
        interactor?.deleteContact(for: contact)
    }
}

extension ContactListPresenter: ContactListInteractorOutputProtocol {
    
    func didContactDeleteSuccessfully() {
        view?.hideLoading()
        view?.contactDeletedSuccessfully()
    }
    
    func didRetrieveContacts(_ contacts: ContactList) {
        view?.hideLoading()
        view?.showContacts(with: contacts)
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
    
}
