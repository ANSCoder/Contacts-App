//
//  ContactDetailsView.swift
//  Contacts-App
//
//  Created by Anand Nimje on 06/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit
import MessageUI

class ContactDetailsView: UIViewController {
    
    var presenter: ContactDetailPresenterProtocol?
    @IBOutlet weak var tableContactDetail: UITableView!
    var contactDetail = [[String: String]]()
    var contactDetailsList = ContactDetailList()
    let loadingViewController = LoadingViewController()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
        presenter?.viewDidLoad()
    }
    
    func viewSetup(){
        tableViewSetup()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onTapEditContact))
        
        NotificationCenter
            .default
            .addObserver(forName: .refreshDetailsView,
                         object: nil,
                         queue: nil) { [weak self] _ in
                            guard self?.contactDetailsList.count != 0 else {
                                return
                            }
                            self?.makeFavourite(self?.contactDetailsList[0])
        }
    }
    
    func tableViewSetup(){
        tableContactDetail.register(UINib(nibName: "ContactDetailCell",
                                          bundle: nil),
                                    forCellReuseIdentifier: "ContactDetailCell")
        tableContactDetail.register(UINib(nibName: "ContactDetailsHeaderView",
                                          bundle: nil),
                                    forHeaderFooterViewReuseIdentifier: "ContactDetailsHeaderView")
        tableContactDetail.tableFooterView = UIView()
    }
    
    //MARK: - Update Contact Details
    @objc func onTapEditContact(){
        guard contactDetailsList.count != 0 else {
            return
        }
        presenter?.updateContactDetails(for: contactDetailsList[0])
    }
    
    func callNumber(phoneNumber: String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:],
                                     completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                }
            }
        }
    }
    
    func makeFavourite(_ contact: ContactDetailModel?){
        guard contact != nil, var details = contact else {
            return
        }
        details.favorite =  details.favorite ? false : true
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(details)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData,
                                                              options: []) as? [String: Any] ?? [:]
            presenter?.contactAddToFavourite(for: String(details.id),
                                             details: dictionary)
        } catch {
            print("Unexpected error: \(error).")
        }
        
    }
}

extension ContactDetailsView: ContactDetailViewProtocol {
    
    func contactAddedToFavourite(_ details: ContactDetailModel) {
        DispatchQueue.main.async {[weak self] in
            self?.setUpDataForUI(details)
        }
    }
    
    func showContactDetail(forContact details: ContactDetailModel) {
        DispatchQueue.main.async {[weak self] in
            self?.setUpDataForUI(details)
        }
    }
    
    func setUpDataForUI(_ details: ContactDetailModel){
        //Create contact Details
        contactDetailsList = []
        contactDetailsList.append(details)
        contactDetail = [["title": "mobile", "value": details.phoneNumber],
                         ["title": "email", "value": details.email]]
        tableContactDetail.reloadData()
    }
    
    func showError() {
        showAleartViewwithTitle("Error!", message: "Something went wrong!")
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 346.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ContactDetailsHeaderView" ) as? ContactDetailsHeaderView else {
            debugPrint("HeaderView Identifier not found!")
            return nil
        }
        guard contactDetailsList.count != 0 else {
            return headerView
        }
        headerView.configHeader(for: contactDetailsList[section])
        headerView.subscribeMessageAction = { [weak self] in
            self?.sendMessage(for: self?.contactDetailsList[section].phoneNumber ?? "")
        }
        headerView.subscribeCallAction = { [weak self] in
            self?.callNumber(phoneNumber: self?.contactDetailsList[section].phoneNumber ?? "")
        }
        headerView.subscribeEmailAction = { [weak self] in
            self?.sendEmail(for: self?.contactDetailsList[section].email ?? "")
        }
        headerView.subscribeFavouriteAction = { [weak self] in
            self?.makeFavourite(self?.contactDetailsList[section])
        }
        return headerView
    }
}

extension ContactDetailsView: MFMailComposeViewControllerDelegate{
    
    func sendEmail(for emailId: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([emailId])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            showAleartViewwithTitle("Error!", message: "Email not configured.")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension ContactDetailsView: MFMessageComposeViewControllerDelegate{
    
    func sendMessage(for phoneNumber: String) {
        if MFMessageComposeViewController.canSendText() {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = [phoneNumber]
            controller.messageComposeDelegate = self
            present(controller, animated: true, completion: nil)
        } else {
            showAleartViewwithTitle("Error!", message: "Unable to send message.")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult){
        
        dismiss(animated: true, completion: nil)
    }
}
