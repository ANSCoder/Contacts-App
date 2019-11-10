//
//  ContactDetailsHeaderView.swift
//  Contacts-App
//
//  Created by Anand Nimje on 08/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class ContactDetailsHeaderView: UITableViewHeaderFooterView {
    
    let imageProvider = ImageProvider()
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var buttonMessage: UIButton!
    @IBOutlet weak var buttonCall: UIButton!
    @IBOutlet weak var buttonEmail: UIButton!
    @IBOutlet weak var buttonFavourite: UIButton!
    @IBOutlet weak var favouriteImageView: UIImageView!
    var subscribeMessageAction: (() -> ())?
    var subscribeCallAction: (() -> ())?
    var subscribeEmailAction: (() -> ())?
    var subscribeFavouriteAction: (() -> ())?
    
    override func draw(_ rect: CGRect) {
        profileImageView.makeRounded()
        
        buttonMessage.addTarget(self,
                                action: #selector(subscribeMessageTapped),
                                for: .touchUpInside)
        buttonCall.addTarget(self,
                             action: #selector(subscribeCallTapped),
                             for: .touchUpInside)
        buttonEmail.addTarget(self,
                                action: #selector(subscribeEmailTapped),
                                for: .touchUpInside)
        buttonFavourite.addTarget(self,
                                action: #selector(subscribeFavouriteTapped),
                                for: .touchUpInside)
    }
    
    @objc func subscribeMessageTapped(){
        subscribeMessageAction?()
    }
    
    @objc func subscribeCallTapped(){
        subscribeCallAction?()
    }
    
    @objc func subscribeEmailTapped(){
        subscribeEmailAction?()
    }
    
    @objc func subscribeFavouriteTapped(){
        subscribeFavouriteAction?()
    }
    
    func configHeader(for model: ContactDetailModel){
        fullNameLabel.text = model.fullName()
        favouriteImageView.image = model.favorite ? #imageLiteral(resourceName: "home_favourite") : #imageLiteral(resourceName: "favourite_button")
        guard let mediaUrl = NSURL(string: Endpoints
            .ImagePath
            .profilePic(model.profilePic)
            .url) else {
                return
        }
        let image = imageProvider.cache.object(forKey: mediaUrl)
        profileImageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        profileImageView.image = image
        if image == nil {
            imageProvider.loadImages(from :mediaUrl,
                                     completion: {[weak self] image  in
                                        self?.profileImageView.image = image
            })
        }
    }
}
