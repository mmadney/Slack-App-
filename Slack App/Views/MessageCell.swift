//
//  MessageCell.swift
//  Slack App
//
//  Created by Mohamed on 5/30/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var avtarImage: RoundImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var MesageDate: UILabel!
    @IBOutlet weak var MessageBody: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func ConfigureCell(Message: Message){
        let image = UIImage(named: Message.UserAvatar)
        self.avtarImage.image = image
        self.avtarImage.backgroundColor = UserDataServices.instance.returnUiColor(components: Message.UserAvatarColor)
        self.userName.text = Message.userName
        self.MesageDate.text = Message.TimeStamp
        self.MessageBody.text = Message.messageBody
    }

}
