//
//  ChannelVc.swift
//  Slack App
//
//  Created by Mohamed on 3/12/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit

class ChannelVc: UIViewController,UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var userImg: RoundImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var channelTable: UITableView!
    
    @IBAction func prepareForUnWind(segue : UIStoryboardSegue){}

    override func viewDidLoad() {
        super.viewDidLoad()
        channelTable.delegate = self
        channelTable.dataSource = self
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(UserDataChanged(_:)), name: Notif_UserData_DidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelLoaded(_:)), name: Notif_ChannelData_DidChange, object: nil)
        SocketServices.instance.getchannel { (sucess) in
            if sucess {
                self.channelTable.reloadData()
            }
        }
    }
    @objc func channelLoaded(_ notif: Notification){
        self.channelTable.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    @objc func UserDataChanged(_ notif: Notification){
       setupUserInfo()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageServcies.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell") as? ChannelCell {
            let channel = MessageServcies.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageServcies.instance.channels[indexPath.row]
        MessageServcies.instance.selectChannel = channel
        NotificationCenter.default.post(name: Notif_Channel_Selected, object: nil)
        self.revealViewController()?.revealToggle(animated: true)
    }
    
    func setupUserInfo(){
        if Authservice.instance.isloggedin {
            loginBtn.setTitle(UserDataServices.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataServices.instance.avatarname)
            let color = UserDataServices.instance.returnUiColor()
            userImg.updateBackGroundColor(bgcolor: color)
            
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            channelTable.reloadData()
        }
    }
    
    @IBAction func addchannelBtnTapped(_ sender: Any) {
        if Authservice.instance.isloggedin {
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        } else {
            print("Please Login First")
        }

    }
    
    
    

}

