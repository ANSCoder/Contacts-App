//
//  EditContactWireFrame.swift
//  Contacts-App
//
//  Created by Anand Nimje on 09/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class EditContactWireFrame: EditContactWireFrameProtocol{
    
    static func editContactDetail(forContact contact: ContactDetailModel) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "EditContactView")
        if let view = viewController as? EditContactView {
            let presenter: EditContactPresenterProtocol & EditContactInteractorOutputProtocol = EditContactPresenter()
            let interactor: EditContactInteractorInputProtocol & EditContactRemoteDataOutputProtocol = EditContactIntractor()
            let remoteDataManager: EditContactRemoteDataInputProtocol = EditContactRemote()
            let wireFrame: EditContactWireFrameProtocol = EditContactWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.contact = contact
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            return viewController
        }
        return UIViewController()
    }
    
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
