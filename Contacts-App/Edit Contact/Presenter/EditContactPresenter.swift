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
        
    }
    
}

extension EditContactPresenter: EditContactInteractorOutputProtocol{
    func didSubmittedContactDetails(_ result: Any) {
        
    }
    
    func onError() {
        
    }
}
