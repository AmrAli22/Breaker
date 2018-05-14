//
//  FeedCellVC.swift
//  Breaker
//
//  Created by Amr Ali on 5/5/18.
//  Copyright © 2018 AAA. All rights reserved.
//

import UIKit

class FeedCellVC: UITableViewCell {

    @IBOutlet weak var LblEmailFeed: UILabel!
    @IBOutlet weak var LblPostFeed: UILabel!
    @IBOutlet weak var ImgViewUserFeed: UIImageView!

    func ConfigureCell(ProfileImage: UIImage, email: String , Content: String)
    {
        self.ImgViewUserFeed.image = ProfileImage
        self.LblEmailFeed.text = email
        self.LblPostFeed.text = Content
    }




}
