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
    var contactImage: String!
    var contactDetails = [String: Any]()
    var detailList = [DetailsModel]()
    let imageProvider = ImageProvider()
    var imagePicker: UIImagePickerController!
    var profileImage: UIImage?
    var subscribeImageSelection: ((UIImage) -> ())?
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
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
        guard detailList.count != 0 else {
            debugPrint("Data not found!")
            return
        }
        //Update contact Details
        contactDetails["first_name"] = detailList.filter{ $0.title == "first_name"}.map{$0.value}
        contactDetails["last_name"]  = detailList.filter{ $0.title == "last_name"}.map{$0.value}
        contactDetails["phone_number"] = detailList.filter{ $0.title == "phone_number"}.map{$0.value}
        contactDetails["email"] = detailList.filter{ $0.title == "email"}.map{$0.value}
        
        //If image updated then
        if profileImage != nil {
           let imageData = profileImage?.jpegData(compressionQuality: 4.0)
           let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
           contactDetails["profile_pic"] = imageStr
        }
        //updating contact details
        presenter?.updateContactDetails(for: String(contactDetails["id"] as? Int ?? 0),
                                        details: contactDetails)
    }
    
    //MARK: - Cancel Update Contact Details
    @objc func onTapCancel(){
        dismiss(animated: true, completion: nil)
    }
}

extension EditContactView: EditContactViewProtocol{
    
    func onSuccessfullyUpdated(_ contacts: [String : Any]) {
        dismiss(animated: true, completion: nil)
    }
    
    func showContactDetail(forContact details: ContactDetailModel) {
        contactImage = Endpoints.ImagePath.profilePic(details.profilePic).url
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(details)
            let dic = try JSONSerialization.jsonObject(with: jsonData,
                                                       options: []) as? [String: Any] ?? [:]
            contactDetails = dic
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
        //Uodating values for the changes inside the text fields
        cell.detailsTextUpdated = { [weak self] in
            model.value = $0
            self?.detailList[indexPath.row] = model
        }
        return cell
    }
}

extension EditContactView: UITableViewDelegate, UINavigationControllerDelegate{
    
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
        headerView.subscribeButtonAction = { [weak self] in
            //chose image
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                self?.selectImageFrom(.photoLibrary)
                return
            }
            self?.selectImageFrom(.camera)
        }
        subscribeImageSelection = {[weak self] selectedImage in
            self?.profileImage = selectedImage
            headerView.profileImageView.image = selectedImage
        }
        return headerView
    }
}

extension EditContactView: UIImagePickerControllerDelegate{
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        subscribeImageSelection?(selectedImage)
    }
}
