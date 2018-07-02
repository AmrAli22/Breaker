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
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    func GetAllMasseges(handler: @escaping (_ messages: [Massege]) -> ()){
        var  messageArray = [Massege]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMassegesSnapShot) in
            guard let feedMassegesSnapShot = feedMassegesSnapShot.children.allObjects as?
                [DataSnapshot] else {return}
            for messege in feedMassegesSnapShot
            {
                let content = messege.childSnapshot(forPath: "content").value as! String
                let senderId = messege.childSnapshot(forPath: "senderid").value as! String
                let messege = Massege(Content: content, SenderId: senderId)
                messageArray.append(messege)
            }
            handler(messageArray)
        }
    }
    
    func getAllFeedMessages(handler: @escaping (_ messages: [Massege]) -> ()) {
        var messageArray = [Massege]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderid").value as! String
                let message = Massege(Content: content, SenderId: senderId)
                messageArray.append(message)
            }
            
            handler(messageArray)
        }
    }
    
    
    func getAllMessagesFor(desiredGroup: Group, handler: @escaping (_ messagesArray: [Massege]) -> ()) {
        var groupMessageArray = [Massege]()
        REF_GROUPS.child(desiredGroup.key).child("messages").observeSingleEvent(of: .value) { (groupMessageSnapshot) in
            guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for groupMessage in groupMessageSnapshot {
                let content = groupMessage.childSnapshot(forPath: "content").value as! String
                let senderId = groupMessage.childSnapshot(forPath: "senderid").value as! String
                let groupMessage = Massege(Content: content, SenderId: senderId)
                groupMessageArray.append(groupMessage)
            }
            handler(groupMessageArray)
        }
    }
    
    func getEmail(forSearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    
    func getUsername(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    
    func getIds(forUsernames usernames: [String], handler: @escaping (_ uidArray: [String]) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            var idArray = [String]()
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if usernames.contains(email) {
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
    }
    
    func getEmailsFor(group: Group, handler: @escaping (_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                if group.members.contains(user.key) {
                    let email = user.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func createGroup(withTitle title: String, andDescription description: String, forUserIds ids: [String], handler: @escaping (_ groupCreated: Bool) -> ()) {
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": ids])
        handler(true)
    }
    
    
    
    
    func getAllGroups(handler: @escaping (_ groupsArray: [Group]) -> ()) {
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for group in groupSnapshot {
                let memberArray = group.childSnapshot(forPath: "members").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.uid)!) {
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let description = group.childSnapshot(forPath: "description").value as! String
                    let group = Group(title: title, description: description, key: group.key, members: memberArray, memberCount: memberArray.count)
                    groupsArray.append(group)
                }
            }
            handler(groupsArray)
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


    

    
    
    
    
    
    
    
    
    

