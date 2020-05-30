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
    
    
    
}
