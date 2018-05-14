//
//  AuthService.swift
//  Breaker
//
//  Created by Amr Ali on 4/30/18.
//  Copyright © 2018 AAA. All rights reserved.
//

import Foundation
import Firebase

class AuthService{
    
    static let instance = AuthService()
    
    func registerUser( withEmail email:String, andPassword password:
        String, userCreationComplete: @escaping(_ status: Bool, _ error: Error?)->()){
        Auth.auth().createUser(withEmail: email, password: password) {(user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            let userData = ["provider": user.providerID ,"email": user.email]
        DataService.instance.CreateUser(uid: user.uid , UserData: userData )
            userCreationComplete(true,nil)
        }
    }
    
    
    func loginUser( withEmail email:String, andPassword password:
        String, LoginComplete: @escaping(_ status: Bool, _ error: Error?)->()){
        
        Auth.auth().signIn(withEmail: email , password: password) {
            (user,error) in
            if error != nil{
                LoginComplete(false,error)
                return
            }else{
            LoginComplete(true,nil)
            }
        }
    }
}
