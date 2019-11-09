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
    let displayInformation = ["first_name" : "First Name",
                              "last_name" : "Last Name",
                              "phone_number" : "Mobile",
                              "email" : "Email"]
    var contactImage: String!
    var detailList = [DetailsModel]()
    let imageProvider = ImageProvider()
    
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
        presenter?.viewDidLoad()
    }
    
    func tableViewSetup(){
        tableUpdateContact.register(UINib(nibName: "UpdateDetailsCell",
                                          bundle: nil),
                                    forCellReuseIdentifier: "UpdateDetailsCell")
        tableUpdateContact.register(UINib(nibName: "EditContactHeaderView",
                                          bundle: nil),
                                    forHeaderFooterViewReuseIdentifier: "EditContactHeaderView")
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
    
    func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
    
    func showContactDetail(forContact details: ContactDetailModel) {
        contactImage = Endpoints.ImagePath.profilePic(details.profilePic).url
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(details)
            let dic = try JSONSerialization.jsonObject(with: jsonData,
                                                       options: []) as? [String: Any] ?? [:]
            let modifiedDetails = dic.map{["title":"\($0)", "value": "\($1)"]}
                .filter{ displayInformation.keys.contains($0["title"] ?? "")}
            detailList = modifiedDetails.map(DetailsModel.init)
            tableUpdateContact.reloadData()
        } catch {
            print("Unexpected error: \(error).")
        }
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

//MARK: - Table View DataSource Methods
extension EditContactView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UpdateDetailsCell") as? UpdateDetailsCell else {
            debugPrint("Cell Identifier not found!")
            return UITableViewCell()
        }
        let model = detailList[indexPath.row]
        cell.titleLabel.text = displayInformation[model.title]
        cell.detailsTextView.text = model.value
        return cell
    }
}

extension EditContactView: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 307.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "EditContactHeaderView" ) as? EditContactHeaderView else {
            debugPrint("HeaderView Identifier not found!")
            return nil
        }
        guard let mediaUrl = NSURL(string: contactImage) else {
            return headerView
        }
        let image = imageProvider.cache.object(forKey: mediaUrl)
        headerView.profileImageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        headerView.profileImageView.image = image
        if image == nil {
            imageProvider.loadImages(from :mediaUrl,
                                     completion: { image  in
                headerView.profileImageView.image = image
            })
        }
        return headerView
    }
}
