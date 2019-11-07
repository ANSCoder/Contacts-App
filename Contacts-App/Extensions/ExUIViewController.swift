//
//  ExUIViewController.swift
//  Contacts-App
//
//  Created by Anand Nimje on 07/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

extension UIViewController {
    static var loading: UIViewController {
        let viewController = UIViewController()

        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        viewController.view.addSubview(indicator)

        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(
                equalTo: viewController.view.centerXAnchor
            ),
            indicator.centerYAnchor.constraint(
                equalTo: viewController.view.centerYAnchor
            )
        ])

        return viewController
    }
}
