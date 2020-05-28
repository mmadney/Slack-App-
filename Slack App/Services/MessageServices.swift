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
    
    func getChannel(completion : @escaping completionHandler){
        let channel1 = Channel(_id: "1", name: "general", description: "this general", __v: 5)
        let channel2 = Channel(_id: "2", name: "development", description: "this general", __v: 5)
        channels.append(channel1)
        channels.append(channel2)
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
                }
                
                print(self.channels)

            case .failure(let error):
                debugPrint(error)
                completion(false)
            }
        }
    }
    

}
