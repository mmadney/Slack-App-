//
//  ChannelVc.swift
//  Slack App
//
//  Created by Mohamed on 3/12/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit

class ChannelVc: UIViewController {
    
    @IBOutlet weak var userImg: RoundImageView!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func prepareForUnWind(segue : UIStoryboardSegue){}

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(UserDataChanged(_:)), name: Notif_UserData_DidChange, object: nil)
    }
    
    @objc func UserDataChanged(_ notif: Notification){
        if Authservice.instance.isloggedin {
            loginBtn.setTitle(UserDataServices.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataServices.instance.avatarname)
            let color = UserDataServices.instance.returnUiColor()
            userImg.updateBackGroundColor(bgcolor: color)
            
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        if Authservice.instance.isloggedin {
            let profileVc = ProfileVC()
            profileVc.modalPresentationStyle = .custom
            present(profileVc, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: to_Login, sender: nil)
        }
       
    }
    
    

}

