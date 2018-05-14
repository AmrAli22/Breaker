//
//  DataService.swift
//  Breaker
//
//  Created by Amr Ali on 4/30/18.
//  Copyright © 2018 AAA. All rights reserved.
//

import Foundation
import Firebase

let DBBASE = Database.database().reference()


class DataService{
    static let instance = DataService()
    
    private var _REF_BASE = DBBASE
    private var _REF_USERS = DBBASE.child("users")
    private var _REF_GROUPS = DBBASE.child("groups")
    private var _REF_FEED = DBBASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    func GetAllMasseges(handler: @escaping (_ messages: [Massege]) -> ()){
        var  messageArray = [Massege]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMassegesSnapShot) in
            guard let feedMassegesSnapShot = feedMassegesSnapShot.children.allObjects as?
                [DataSnapshot] else {return}
            for messege in feedMassegesSnapShot
            {
                let content = messege.childSnapshot(forPath: "content").value as! String
                let senderId = messege.childSnapshot(forPath: "senderId").value as! String
                let messege = Massege(Content: content, SenderId: senderId)
                messageArray.append(messege)
            }
            handler(messageArray)
        }
    }
    
    func CreateUser(uid: String, UserData: Dictionary<String,Any> )
    {
    REF_USERS.child(uid).updateChildValues(UserData)
    }
    
    func UploadPost(withMessage messege: String , ForId Uid: String , WithGroupKey GroupKey: String?, SendComplete: @escaping (_ status: Bool)->())
    {
        if GroupKey != nil
        {
            
        }
        else
        {
            REF_FEED.childByAutoId().updateChildValues(["content": messege, "senderid": Uid])
            SendComplete(true)
        }
    }
}
    
    
    
    
    
    
    
    
    
    
    

