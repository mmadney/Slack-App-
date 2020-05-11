//
//  ProfileVC.swift
//  Slack App
//
//  Created by Mohamed on 5/11/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var ProfileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillProfileView()
    }
    
    func fillProfileView(){
        self.ProfileImg.image = UIImage(named: UserDataServices.instance.avatarname)
        self.userName.text = UserDataServices.instance.name
        self.email.text = UserDataServices.instance.email
        self.ProfileImg.backgroundColor = UserDataServices.instance.returnUiColor()
        let closeToush = UITapGestureRecognizer(target: self, action: nil)
        bgView.addGestureRecognizer(closeToush)
    }

    @IBAction func closeModelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        UserDataServices.instance.logoutUser()
        NotificationCenter.default.post(name: Notif_UserData_DidChange, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }

}
