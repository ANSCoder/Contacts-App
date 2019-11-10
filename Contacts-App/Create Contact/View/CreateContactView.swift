//
//  CreateContactView.swift
//  Contacts-App
//
//  Created by Anand Nimje on 10/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class CreateContactView: UIViewController {
    
    var presenter: CreateContactPresenterProtocol?
    let loadingViewController = LoadingViewController()
    @IBOutlet weak var tableCreateContact: UITableView!
    var contactDetails = [String: Any]()
    var detailList = [DetailsModel]()
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
    }
    
    func tableViewSetup(){
        tableCreateContact.register(UINib(nibName: "UpdateDetailsCell",
                                          bundle: nil),
                                    forCellReuseIdentifier: "UpdateDetailsCell")
        tableCreateContact.register(UINib(nibName: "EditContactHeaderView",
                                          bundle: nil),
                                    forHeaderFooterViewReuseIdentifier: "EditContactHeaderView")
        tableCreateContact.tableFooterView = UIView()
        
        DispatchQueue.main.async { [weak self] in
            self?.detailList = displayInformation.keys
                .map{["title":"\($0)", "value": ""]}
                .map(DetailsModel.init)
            self?.tableCreateContact.reloadData()
        }
    }
    
    //MARK: - Update Contact Details
    @objc func onTapDone(){
        //Update contact Details
        contactDetails["first_name"] = detailList.filter{ $0.title == "first_name"}
                                                 .map{$0.value}.first ?? ""
        contactDetails["last_name"]  = detailList.filter{ $0.title == "last_name"}
                                                 .map{$0.value}.first ?? ""
        contactDetails["phone_number"] = detailList.filter{ $0.title == "phone_number"}
                                                 .map{$0.value}.first ?? ""
        contactDetails["email"] = detailList.filter{ $0.title == "email"}
                                                 .map{$0.value}.first ?? ""
        contactDetails["favorite"] = false
        
        //If image updated then
        if profileImage != nil {
           let imageData = profileImage?.jpegData(compressionQuality: 4.0)
           let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
           contactDetails["profile_pic"] = imageStr
        }
        contactDetails["profile_pic"] = "/images/missing.png"
        //updating contact details
        presenter?.createContact(for: contactDetails)
    }
    
    //MARK: - Cancel Update Contact Details
    @objc func onTapCancel(){
        dismiss(animated: true, completion: nil)
    }
}

extension CreateContactView: CreateContactViewProtocol{
    
    func showError() {
    }
    
    func showLoading() {
        add(loadingViewController)
    }
    
    func hideLoading() {
        loadingViewController.remove()
    }
    
    //MARK: - Contact created response
    func onSuccessfullyCreate(_ contacts: [String : Any]) {
        showAlertWithMessage("Contact created successfully!") { [weak self] in
            DispatchQueue.main.async {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

//MARK: - Table View DataSource Methods
extension CreateContactView: UITableViewDataSource{
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

extension CreateContactView: UITableViewDelegate, UINavigationControllerDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 307.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "EditContactHeaderView" )
                                                                    as? EditContactHeaderView else {
            debugPrint("HeaderView Identifier not found!")
            return nil
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

extension CreateContactView: UIImagePickerControllerDelegate{
    
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
