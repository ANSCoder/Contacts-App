//
//  EditContactView.swift
//  Contacts-App
//
//  Created by Anand Nimje on 06/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class EditContactView: UIViewController {

    var presenter: EditContactPresenterProtocol?
    let loadingViewController = LoadingViewController()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSetup()
    }
    
    func viewSetup(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onTapDone))
    }
    
    //MARK: - Update Contact Details
    @objc func onTapDone(){
        
    }
    
    @objc func onTapCancel(){
        
    }
}

extension EditContactView: EditContactViewProtocol{
    
    func showContactDetail(forContact details: ContactDetailModel) {
        
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        add(loadingViewController)
    }
    
    func hideLoading() {
        loadingViewController.remove()
    }
}
