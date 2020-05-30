//
//  SocketServices.swift
//  Slack App
//
//  Created by Mohamed on 5/29/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import Foundation
import SocketIO

class SocketServices : NSObject{
    
    static let instance = SocketServices()
    
    let manager : SocketManager
    let socket: SocketIOClient
    
    override init() {
        self.manager = SocketManager(socketURL: URL(string: Base_Url)!)
        self.socket = manager.defaultSocket
        super.init()
    }
    
    func establishConnection(){
        socket.connect()
    }
    
    func closConnection(){
        socket.disconnect()
    }
    // add channel to server event
    func AddChannel(channelName:String, channelDescrption:String,completion: @escaping completionHandler){
        socket.emit("newChannel", channelName, channelDescrption)
        completion(true)
    }
    
    //listnen to channel event
    func getchannel(completion: @escaping completionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            
            let newChannel = Channel(_id: channelId, name: channelName, description: channelDesc, __v: 5)
            MessageServcies.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody:String,userId: String,channelId:String,completion: @escaping completionHandler){
        let user = UserDataServices.instance
        socket.emit("newMessage", messageBody,userId,channelId,user.name,user.avatarname,user.avatarColor)
        completion(true)
    }
    
    func getMessage(completion: @escaping completionHandler){
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String else {return}
            guard let userId = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let messageId = dataArray[6] as? String else {return}
            guard let messageTime = dataArray[7] as? String else {return}
            if channelId == MessageServcies.instance.selectChannel?._id && Authservice.instance.isloggedin {
                let newMessage = Message(messageId: messageId, messageBody: messageBody, userId: userId, ChannelId: channelId, userName: userName, UserAvatar: userAvatar, UserAvatarColor: userAvatarColor, TimeStamp: messageTime)
                MessageServcies.instance.messages.append(newMessage)
                completion(true)
            } else {
                completion(false)
            }
           
        }
    }
    
    func getTypingUser(_ completionHandler: @escaping(_ typingUser:[String : String]) -> Void){
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typinguser = dataArray[0] as? [String: String] else {return}
            completionHandler(typinguser)
        }
    }
    
}
