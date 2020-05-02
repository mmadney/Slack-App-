//
//  UserDataServices.swift
//  Slack App
//
//  Created by Mohamed on 3/22/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import Foundation

class  UserDataServices{
    
    static let instance =  UserDataServices()
    
    public private(set) var id = ""
    public private(set) var email = ""
    public private(set) var avatarname = ""
    public private (set) var name = ""
    public private(set) var avatarColor = ""
    
    
    func setUserDataServices(id : String , email : String , avatarName : String , name:String, avatarColor:String){
        self.id = id
        self.email = email
        self.avatarname = avatarName
        self.name = name
        self.avatarColor = avatarColor
    }
    
    func setAvtarName(avatarName:String) {
        self.avatarname = avatarName
    }
    
    
}
