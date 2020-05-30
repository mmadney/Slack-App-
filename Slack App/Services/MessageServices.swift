//
//  MessageServices.swift
//  Slack App
//
//  Created by Mohamed on 5/27/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageServcies {
    
    static let instance = MessageServcies()
    
    var channels = [Channel]()
    var selectChannel : Channel?
    var messages = [Message]()
    
    func getChannel(completion : @escaping completionHandler){
        AF.request(URL_Get_Channel, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            switch response.result{
            case .success(_):
//                do{
//                    self.channels = try JSONDecoder().decode([Channel].self, from: response.data!)
//                    completion(true)
//                } catch let error {
//                    debugPrint(error)
//                    completion(false)
//                }
//                print(self.channels)
                do {
                    if let json = try JSON(data: response.data!).array{
                        for item in json {
                            let name = item["name"].stringValue
                            let channelDescription = item["descrption"].stringValue
                            let id = item["_id"].stringValue
                            let channel = Channel(_id: id, name: name, description: channelDescription)
                            self.channels.append(channel)
                        }
                        completion(true)
                    }
                } catch let error {
                    print(error)
                    completion(false)
                }
                NotificationCenter.default.post(name: Notif_ChannelData_DidChange, object: nil)

            case .failure(let error):
                debugPrint(error)
                completion(false)
            }
        }
    }
    
    func findAllMessageForChannel(channelid:String, completion: @escaping completionHandler){
        AF.request("\(URL_Get_Message)\(channelid)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON{ (response) in
            switch response.result {
            case .success(_):
                self.ClearMessage()
                do {
                    if let json = try JSON(data: response.data!).array {
                        for item in json {
                            let messageId = item["_id"].stringValue
                            let messageBody = item["messageBody"].stringValue
                            let userId = item["userId"].stringValue
                            let channelId = item["channelId"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            let message = Message(messageId: messageId, messageBody: messageBody, userId: userId, ChannelId: channelId, userName: userName, UserAvatar: userAvatar, UserAvatarColor: userAvatarColor, TimeStamp: timeStamp)
                            self.messages.append(message)
                        }
                        completion(true)
                    }
                } catch let error {
                    debugPrint(error)
                    completion(false)
                }
            case .failure(let error):
                debugPrint(error)
                completion(false)
            }
            
        }
    }
    
    
    func clearChannel(){
        channels.removeAll()
    }
    
    func ClearMessage(){
        messages.removeAll()
    }

}
