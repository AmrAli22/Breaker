//
//  AuthVC.swift
//  Breaker
//
//  Created by Amr Ali on 5/1/18.
//  Copyright © 2018 AAA. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ActBtnSignInWithEmail(_ sender: Any)
    {
      let LoginVC = storyboard?.instantiateViewController(withIdentifier:"Loginvc")
        present(LoginVC!, animated: true, completion: nil)
    }
    @IBAction func ActBtnSigninWithG(_ sender: Any)
    {
        
    }
    @IBAction func ActBtnSigninWithFB(_ sender: Any)
    {
        
    }
    
}