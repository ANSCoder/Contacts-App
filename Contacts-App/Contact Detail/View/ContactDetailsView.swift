//
//  ContactDetailsView.swift
//  Contacts-App
//
//  Created by Anand Nimje on 06/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class ContactDetailsView: UIViewController {
    
    var presenter: ContactDetailPresenterProtocol?
    @IBOutlet weak var tableContactDetail: UITableView!
    var contactDetail = [[String: String]]()
    let loadingViewController = LoadingViewController()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
    }
    
    func viewSetup(){
        tableContactDetail.register(UINib(nibName: "ContactDetailCell",
                                        bundle: nil),
                                  forCellReuseIdentifier: "ContactDetailCell")
        tableContactDetail.tableFooterView = UIView()
        presenter?.viewDidLoad()
    }
}

extension ContactDetailsView: ContactDetailViewProtocol {

    func showContactDetail(forContact details: ContactDetailModel) {
        //Create contact Details
        contactDetail = [["title": "mobile", "value": details.phoneNumber],
                         ["title": "email", "value": details.email]]
        tableContactDetail.reloadData()
    }
    
    func showError() {
        //"Internet not connected"
    }
    
    func showLoading() {
        add(loadingViewController)
    }
    
    func hideLoading() {
        loadingViewController.remove()
    }
}


//MARK: - Table View DataSource Methods
extension ContactDetailsView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDetailCell") as? ContactDetailCell else {
            debugPrint("Cell Identifier not found!")
            return UITableViewCell()
        }
        let model = contactDetail[indexPath.row]
        cell.titleLabel.text = model["title"]
        cell.detailLabel.text = model["value"]
        return cell
    }
}

extension ContactDetailsView: UITableViewDelegate{
    
}
