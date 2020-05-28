//
//  LoginVc.swift
//  Slack App
//
//  Created by Mohamed on 3/12/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit

class LoginVc: UIViewController {
    
    @IBOutlet weak var password: texetPlaceHolder!
    @IBOutlet weak var userName: texetPlaceHolder!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        

    }
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func accountBtn(_ sender: Any) {
        performSegue(withIdentifier: to_Account, sender: nil)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        guard let email = userName.text , userName.text != "" else {
            return
        }
        guard let userpassword = password.text, password.text != "" else {
            return
        }
        Authservice.instance.loginUser(email: email, password: userpassword) { (sucess) in
            if sucess{
                Authservice.instance.findUserByEmail { (sucess) in
                    if sucess{
                        NotificationCenter.default.post(name: Notif_UserData_DidChange, object: nil)
                        self.spinner.isHidden = false
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    
    
}
