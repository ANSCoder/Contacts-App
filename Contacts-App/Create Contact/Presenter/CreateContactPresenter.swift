//
//  CreateContactPresenter.swift
//  Contacts-App
//
//  Created by Anand Nimje on 10/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation

class CreateContactPresenter: CreateContactPresenterProtocol {
    var view: CreateContactViewProtocol?
    
    var interactor: CreateContactInteractorInputProtocol?
    
    var wireFrame: CreateContactWireFrameProtocol?
    
    func viewDidLoad() {
        
    }
    
    func createContact(for details: [String : Any]) {
        view?.showLoading()
        interactor?.createContact(for: details)
    }
}

extension CreateContactPresenter: CreateContactInteractorOutputProtocol{
    
    func didCreatedNewContact(_ result: [String : Any]) {
        view?.hideLoading()
        view?.onSuccessfullyCreate(result)
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }

}
