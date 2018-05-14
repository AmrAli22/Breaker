//
//  LoginVC.swift
//  Breaker
//
//  Created by Amr Ali on 5/1/18.
//  Copyright © 2018 AAA. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var TxtEmail: InsetTextField!
    @IBOutlet weak var TxtPass: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TxtPass.delegate = self
        TxtEmail.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ActBtnSignin(_ sender: Any)
    {
        if TxtEmail.text != nil && TxtPass.text != nil{
            AuthService.instance.loginUser(withEmail: TxtEmail.text!, andPassword: TxtPass.text!, LoginComplete: {
                (success, LoginError) in
                if success{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print (String(describing: LoginError?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.TxtEmail.text!, andPassword: self.TxtPass.text!, userCreationComplete: {
                    (success,RegistrationError) in
                    if success{
                        AuthService.instance.loginUser(withEmail: self.TxtEmail.text!, andPassword: self.TxtPass.text!, LoginComplete: {(success, nil) in
                        self.dismiss(animated: true, completion: nil)
                            print("Successful Registration")
                        })
                    }else{
                        print(String(describing: RegistrationError?.localizedDescription))
                    }
                })
            })
        }
    }
    @IBAction func ActBtnClose(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
    }
    
}

extension LoginVC: UITextFieldDelegate { }


