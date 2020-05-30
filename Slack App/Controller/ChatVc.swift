//
//  ChatVc.swift
//  Slack App
//
//  Created by Mohamed on 3/12/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit
import Alamofire

class ChatVc: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var slackLabel: UILabel!
    @IBOutlet weak var MessageTextField: UITextField!
    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var typingUserLbl: UILabel!
    
    //Vriable
    var isTyping = false

    override func viewDidLoad() {
        super.viewDidLoad()
        messageTable.delegate = self
        messageTable.dataSource = self
        messageTable.estimatedRowHeight = 80
        messageTable.rowHeight = UITableView.automaticDimension
        sendBtn.isHidden = true
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handelViewTap(_:)))
        view.addGestureRecognizer(tap)
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
        
        SocketServices.instance.getMessage { (sucess) in
            if sucess {
                self.messageTable.reloadData()
                if MessageServcies.instance.messages.count > 0 {
                    let endexPath = IndexPath(row: MessageServcies.instance.messages.count - 1, section: 0)
                    self.messageTable.scrollToRow(at: endexPath, at: .bottom, animated: false)
                }
            }
        }
        
        SocketServices.instance.getTypingUser { (typingUsers) in
            guard let channelId = MessageServcies.instance.selectChannel?._id else {return}
            var names  = ""
            var numberOfTypers = 0
            for(typinguser , channel) in typingUsers {
                if typinguser != UserDataServices.instance.name && channel == channelId {
                    if names == "" {
                        names = typinguser
                    } else {
                        names = "\(names),\(typinguser)"
                    }
                    numberOfTypers += 1
                }
            }
            
            if numberOfTypers > 0 && Authservice.instance.isloggedin == true {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingUserLbl.text = "\(names) \(verb) typing a message..."
            } else {
                self.typingUserLbl.text = ""
            }
        }
        

    }
    
    @objc func handelViewTap(_ sender: Any){
        view.endEditing(true)
    }
    
    @objc func UserDataChanged(_ notif: Notification){
        if Authservice.instance.isloggedin{
            //getChannel
            OnloginGetMessage()
        } else {
            slackLabel.text = "Please Log In..."
            messageTable.reloadData()
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
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        guard let channelId = MessageServcies.instance.selectChannel?._id else {
            return
        }
        if MessageTextField.text == "" {
            isTyping = false
            sendBtn.isHidden = true
            SocketServices.instance.socket.emit("stopType", UserDataServices.instance.name,channelId)
        } else {
            if isTyping == false {
                sendBtn.isHidden = false
                SocketServices.instance.socket.emit("startType", UserDataServices.instance.name,channelId)
            }
            isTyping = true
        }
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if Authservice.instance.isloggedin {
            guard let channelId = MessageServcies.instance.selectChannel?._id else {
                return
            }
            guard let message = MessageTextField.text, MessageTextField.text != "" else {
                return
            }
            
            SocketServices.instance.addMessage(messageBody: message, userId: UserDataServices.instance.id, channelId: channelId) { (sucess) in
                if sucess {
                    self.MessageTextField.text = ""
                    self.MessageTextField.resignFirstResponder()
                }
            }
        }
        
    }
    
    
    func getMessage(){
        guard  let channelId = MessageServcies.instance.selectChannel?._id else {
            return
        }
        MessageServcies.instance.findAllMessageForChannel(channelid: channelId) { (sucess) in
            if sucess {
                self.messageTable.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageServcies.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = messageTable.dequeueReusableCell(withIdentifier: messageCell, for: indexPath) as? MessageCell {
            let message = MessageServcies.instance.messages[indexPath.row]
            cell.ConfigureCell(Message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    

}
