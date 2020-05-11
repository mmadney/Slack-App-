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
    @IBOutlet weak var userImg: RoundImageView!
    @IBOutlet weak var activityIndictor: UIActivityIndicatorView!
    
    var avtarname = "ProfileDefualt"
    var avatarColor = "[0.5,0.5,0.5,1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndictor.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handdleTap(_:)))
        view.addGestureRecognizer(tap)
    }
    override func viewDidAppear(_ animated: Bool) {
      if UserDataServices.instance.avatarname != "" {
          self.userImg.image = UIImage(named: UserDataServices.instance.avatarname)
          self.avtarname = UserDataServices.instance.avatarname
        if avtarname.contains("light") && userImg.checkBgCoLor() {
            userImg.backgroundColor = UIColor.lightGray
        }
       }
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        
    }
    
    @objc func handdleTap(_ sender: Any){
        view.endEditing(true)
    }
    
    
    @IBAction func choiceAvtarTapped(_ sender: Any) {
          performSegue(withIdentifier: To_AvatarPicker, sender: nil)
    }
    
    @IBAction func GenerateBackGroundColorTapped(_ sender: Any) {
        avatarColor = userImg.changeBackgroundColor()
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        activityIndictor.isHidden = false
        activityIndictor.startAnimating()
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
                                self.activityIndictor.isHidden = true
                                self.activityIndictor.stopAnimating()
                                self.unwindtoChannel()
                                NotificationCenter.default.post(name: Notif_UserData_DidChange, object: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    func unwindtoChannel(){
        performSegue(withIdentifier: unWind, sender: nil)
    }

    
}
