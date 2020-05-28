//
//  ChatVc.swift
//  Slack App
//
//  Created by Mohamed on 3/12/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit
import Alamofire

class ChatVc: UIViewController {
    
    @IBOutlet weak var menuBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController()!.panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController()!.tapGestureRecognizer())
        if Authservice.instance.isloggedin {
            Authservice.instance.findUserByEmail { (sucess) in
                NotificationCenter.default.post(name: Notif_UserData_DidChange, object: nil)
            }
        }
        
        MessageServcies.instance.getChannel { (sucess) in
            
        }
    }
    

}
