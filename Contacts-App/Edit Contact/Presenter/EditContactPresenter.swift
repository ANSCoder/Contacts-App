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
    
    /*
     ["profile_pic": /images/missing.png, "favorite": 1, "last_name": Kumar, "first_name": Puneet, "phone_number": +919971384493, "id": 13168, "updated_at": 2019-11-07T13:29:55.340Z, "created_at": 2019-11-03T09:45:50.144Z, "email": kumar.punet@gmail.com]
     */
}

extension EditContactPresenter: EditContactInteractorOutputProtocol{
    func didSubmittedContactDetails(_ result: Any) {
        
    }
    
    func onError() {
        
    }
}
