//
//  EditContactPresenter.swift
//  Contacts-App
//
//  Created by Anand Nimje on 09/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import Foundation

class EditContactPresenter: EditContactPresenterProtocol{
    
    var view: EditContactViewProtocol?
    var interactor: EditContactInteractorInputProtocol?
    var wireFrame: EditContactWireFrameProtocol?
    var contact: ContactDetailModel?
    
    func viewDidLoad() {
        view?.showContactDetail(forContact: contact!)
    }
    
    func updateContactDetails(for contactId: String, details: [String : Any]) {
        view?.showLoading()
        interactor?.updateContactDetails(for: contactId, details: details)
    }
}

extension EditContactPresenter: EditContactInteractorOutputProtocol{
    
    func didSubmittedContactDetails(_ result: [String : Any]) {
        view?.hideLoading()
        view?.onSuccessfullyUpdated(result)
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}
