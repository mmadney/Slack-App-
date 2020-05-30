//
//  Message.swift
//  Slack App
//
//  Created by Mohamed on 5/30/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import Foundation

struct Message {
    
    public private(set) var messageId: String!
    public private(set) var messageBody: String!
    public private(set) var userId: String!
    public private(set) var ChannelId: String!
    public private(set) var userName: String!
    public private(set) var UserAvatar: String!
    public private(set) var UserAvatarColor: String!
    public private(set) var TimeStamp: String!
}
