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
    @IBOutlet weak var tableUpdateContact: UITableView!
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSetup()
    }
    
    func viewSetup(){
        //Bar Buttons setup
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onTapDone))
        tableViewSetup()
    }
    
    func tableViewSetup(){
        tableUpdateContact.register(UINib(nibName: "UpdateDetailsCell",
                                        bundle: nil),
                                  forCellReuseIdentifier: "UpdateDetailsCell")
        tableUpdateContact.register(UINib(nibName: "ContactDetailsHeaderView",
                                          bundle: nil),
                                    forHeaderFooterViewReuseIdentifier: "ContactDetailsHeaderView")
        tableUpdateContact.tableFooterView = UIView()
    }
    
    //MARK: - Update Contact Details
    @objc func onTapDone(){
        //Update contact Details
    }
    
    //MARK: - Cancel Update Contact Details
    @objc func onTapCancel(){
        dismiss(animated: true, completion: nil)
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
