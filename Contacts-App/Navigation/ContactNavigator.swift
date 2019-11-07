//
//  ContactNavigator.swift
//  Contacts-App
//
//  Created by Anand Nimje on 07/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class ContactNavigator: Navigator{
    
    enum Destination {
        case contactDetail
        case editContact
    }
    
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ContactViewControllerFactory
    
    // MARK: - Initializer

    init(navigationController: UINavigationController,
         viewControllerFactory: ContactViewControllerFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    // MARK: - Navigator

    func navigate(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: - Private

    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .contactDetail:
            return ContactDetailsView()
        case .editContact:
            return EditContactView()
        }
    }
}
