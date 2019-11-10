//
//  CreateContactWireFrame.swift
//  Contacts-App
//
//  Created by Anand Nimje on 10/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class CreateContactWireFrame: CreateContactWireFrameProtocol{
    
    static func creatNewContactView() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "CreateContactView")
        if let view = viewController as? CreateContactView {
            let presenter: CreateContactPresenterProtocol & CreateContactInteractorOutputProtocol = CreateContactPresenter()
            let interactor: CreateContactInteractorInputProtocol & CreateContactRemoteDataOutputProtocol = CreateContactInteractor()
            let remoteDataManager: CreateContactRemoteDataInputProtocol = CreateContactRemote()
            let wireFrame: CreateContactWireFrameProtocol = CreateContactWireFrame()
            
            view.presenter = presenter
            presenter.view = view
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
