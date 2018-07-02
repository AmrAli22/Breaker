//
//  MeVC.swift
//  Breaker
//
//  Created by Amr Ali on 5/2/18.
//  Copyright © 2018 AAA. All rights reserved.
//

import UIKit
import Firebase


class MeVC: UIViewController {

    @IBOutlet weak var LblMeEmail: UILabel!
    @IBOutlet weak var ImgMe: UIImageView!
    @IBOutlet weak var TblMe: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.LblMeEmail.text = Auth.auth().currentUser?.email
    }
    
   
    
    @IBAction func BtnLogoutMe(_ sender: Any) {
        
        let logoutPopup = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            do {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
        logoutPopup.addAction(logoutAction)
        present(logoutPopup, animated: true, completion: nil)
        
    }
    

}
