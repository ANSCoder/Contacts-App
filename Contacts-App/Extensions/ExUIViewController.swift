//
//  ExUIViewController.swift
//  Contacts-App
//
//  Created by Anand Nimje on 07/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

extension UIViewController{
    
    //MARK:- Aleart View
    func showAleartViewwithTitle(_ title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Alert View with auto dismiss
    func showAlertWithMessage(_ message: String, with completion: (() -> Void)?){
        let alertController = UIAlertController(title: "Message",
                                                message: message,
                                                preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
        let delay = 3.0 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            alertController.dismiss(animated: true, completion: nil)
            completion?()
        })
    }
}
