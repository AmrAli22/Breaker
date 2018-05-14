//
//  MeVC.swift
//  Breaker
//
//  Created by Amr Ali on 5/2/18.
//  Copyright © 2018 AAA. All rights reserved.
//

import UIKit

class MeVC: UIViewController {

    @IBOutlet weak var LblMeEmail: UILabel!
    @IBOutlet weak var ImgMe: UIImageView!
    @IBOutlet weak var TblMe: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BtnLogoutMe(_ sender: Any) {
    }
    

}
