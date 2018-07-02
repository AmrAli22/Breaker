//
//  PostSomeThing.swift
//  Breaker
//
//  Created by Amr Ali on 5/1/18.
//  Copyright © 2018 AAA. All rights reserved.
//

import UIKit
import Firebase

class PostSomeThingVC: UIViewController {

    @IBOutlet weak var LblEmailPost: UILabel!
    @IBOutlet weak var TxtViewPost: UITextView!
    @IBOutlet weak var ImgViewUserPost: UIImageView!
    @IBOutlet weak var BtnSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TxtViewPost.delegate = self
        BtnSend.bindToKeyboard()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.LblEmailPost.text = Auth.auth().currentUser?.email
    }
    
    
    @IBAction func ActBtnSend(_ sender: Any)
    {
    if TxtViewPost.text != nil && TxtViewPost.text != "Write Some Thing .."
        {
        BtnSend.isEnabled = false
            DataService.instance.UploadPost(withMessage: TxtViewPost.text!, ForId:(Auth.auth().currentUser?.uid)!
                , WithGroupKey: nil, SendComplete: { (isComplete) in
                    if isComplete {
                        self.BtnSend.isEnabled = true
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        self.BtnSend.isEnabled = true
                        print("error") 
                    }
            })
        }
    }
    
    @IBAction func ActBtnClose(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
   
    
    
}




extension PostSomeThingVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        TxtViewPost.text = ""
    }
    
    
    
}


