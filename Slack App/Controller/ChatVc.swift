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
    @IBOutlet weak var slackLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController()!.panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController()!.tapGestureRecognizer())
        NotificationCenter.default.addObserver(self, selector: #selector(UserDataChanged(_:)), name: Notif_UserData_DidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: Notif_Channel_Selected, object: nil)
        if Authservice.instance.isloggedin {
            Authservice.instance.findUserByEmail { (sucess) in
                NotificationCenter.default.post(name: Notif_UserData_DidChange, object: nil)
            }
        }

    }
    
    @objc func UserDataChanged(_ notif: Notification){
        if Authservice.instance.isloggedin{
            //getChannel
            OnloginGetMessage()
        } else {
            slackLabel.text = "Please Log In..."
        }

    }
    @objc func channelSelected(_ notif: Notification){
        updateChannel()
    }
    
    func updateChannel(){
        let channelName = MessageServcies.instance.selectChannel?.name ?? ""
        slackLabel.text = "#\(channelName)"
        getMessage()
    }
    
    func OnloginGetMessage() {
        MessageServcies.instance.getChannel { (sucess) in
            if sucess {
                if MessageServcies.instance.channels.count > 0 {
                    MessageServcies.instance.selectChannel = MessageServcies.instance.channels[0]
                    self.updateChannel()
                } else {
                    self.slackLabel.text = "No Channel Yet!"
                }
            }
        }
    }
    
    func getMessage(){
        guard  let channelId = MessageServcies.instance.selectChannel?._id else {
            return
        }
        MessageServcies.instance.findAllMessageForChannel(channelid: channelId) { (sucess) in
            <#code#>
        }
    }

}
