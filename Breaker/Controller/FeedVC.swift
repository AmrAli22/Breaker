//
//  FeedVC.swift
//  Breaker
//
//  Created by Amr Ali on 4/30/18.
//  Copyright © 2018 AAA. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var TblViewFeed: UITableView!
    var  messageArray = [Massege]()
    override func viewDidLoad() {
        super.viewDidLoad()
        TblViewFeed.delegate = self
        TblViewFeed.dataSource = self

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DataService.instance.GetAllMasseges { (returnedMassagesArray) in
            self.messageArray = returnedMassagesArray
            self.TblViewFeed.reloadData()
        }
    }
    
    

}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = TblViewFeed.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCellVC else {
            return UITableViewCell()
        }
        let image = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        
        
        DataService.instance.getUsername(forUID: message.SenderId ) { (returnedUsername) in
            cell.ConfigureCell(ProfileImage: image!, email: returnedUsername, Content: message.Content)
        }
        
        
        return cell
    }
}







