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
    
    func returnUiColor(components: String) -> UIColor {
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r,g,b,a : NSString?
        scanner.scanUpToCharacters(from: comma,into: &r)
        scanner.scanUpToCharacters(from: comma,into: &g)
        scanner.scanUpToCharacters(from: comma,into: &b)
        scanner.scanUpToCharacters(from: comma,into: &a)
        
        let defualtColor = UIColor.lightGray
        
        guard let rUnwrapped = r else {
            return defualtColor
        }
        guard let gUnwrapped = g else {
            return defualtColor
        }
        guard let bUnwrapped = b else {
            return defualtColor
        }
        guard let aUnwrapped = a else {
            return defualtColor
        }
        let rfolat = CGFloat(rUnwrapped.doubleValue)
        let gfolat = CGFloat(gUnwrapped.doubleValue)
        let bfolat = CGFloat(bUnwrapped.doubleValue)
        let afolat = CGFloat(aUnwrapped.doubleValue)
        
        let newColor = UIColor(red: rfolat, green: gfolat, blue: bfolat, alpha: afolat)
        return newColor
    }
    
    func logoutUser(){
        id = ""
        avatarname = ""
        avatarColor = ""
        email = ""
        name = ""
        Authservice.instance.isloggedin = false
        Authservice.instance.userEmail = ""
        Authservice.instance.autohToken = ""
        MessageServcies.instance.clearChannel()
        MessageServcies.instance.ClearMessage()
    }
}
