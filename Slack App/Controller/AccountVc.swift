//
//  AccountVc.swift
//  Slack App
//
//  Created by Mohamed on 3/13/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit

class AccountVc: UIViewController {
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    var avtarname = "ProfileDefualt"
    var avatarColor = "[0.5,0.5,0.5,1]"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closeBtn(_ sender: Any) {
        performSegue(withIdentifier: unWind, sender: nil)
    }
    
    
    @IBAction func choiceAvtarTapped(_ sender: Any) {
        
    }
    
    @IBAction func GenerateBackGroundColorTapped(_ sender: Any) {
        
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        guard let name = userNameTxt.text , userNameTxt.text != "" else {
            return
        }
        guard let password = passwordTxt.text , passwordTxt.text != "" else {
            return
        }
        guard let email = emailTxt.text , emailTxt.text != "" else {
            return
        }
        
        Authservice.instance.registerUser(email: email, password: password) { (sucess) in
            if sucess {
                Authservice.instance.loginUser(email: email, password: password) { (sucess) in
                    if sucess {
                        Authservice.instance.createUser(name: name, email: email, avatarName: self.avtarname, avatarColor: self.avatarColor) { (sucess) in
                            if sucess {
                                
                                self.performSegue(withIdentifier: unWind, sender: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
}
