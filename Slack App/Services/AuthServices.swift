//
//  AuthServices.swift
//  Slack App
//
//  Created by Mohamed on 3/14/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Authservice {
    
    static let instance = Authservice()
    
    let defualts = UserDefaults.standard
    
    var isloggedin : Bool {
        get {
            return defualts.bool(forKey: Logged_In_Key)
        }
        set {
            defualts.set(newValue , forKey: Logged_In_Key)
        }
    }
    
    var token : Bool {
        get {
            return defualts.bool(forKey: tokenKey)
        }
        set {
            defualts.set(newValue, forKey: tokenKey)
        }
        
    }
    
    var Email : Bool {
        get {
            return defualts.bool(forKey: bool_Email)
        }
        set {
            defualts.set(newValue, forKey: bool_Email)
        }
    }
    
    var userEmail : String {
        get {
            return defualts.value(forKey: user_Email) as! String
        }
        set {
            defualts.set(newValue, forKey: user_Email)
        }
    }
    
    var autohToken : String {
        get {
            return defualts.value(forKey: authoreToken) as!String
        }
        set {
            defualts.set(newValue, forKey: authoreToken)
        }
    }
    
    func registerUser(email : String, password : String, completion : @escaping completionHandler) {
        let lowecaseEmail = email.lowercased()
        let body  = ["email": lowecaseEmail , "password" : password ]
        AF.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: Header).responseString { (response) in
            if response.error == nil {
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }
    
   func loginUser(email:String, password:String, completion : @escaping completionHandler) {
        let lowecaseEmail = email.lowercased()
        let body = ["email" : lowecaseEmail , "password" : password]
        AF.request(URL_LOGIN, method: .post, parameters: body, encoding : JSONEncoding.default, headers: Header).responseJSON { (response) in
            
//            switch response.result {
//            case .success(let value) :
//                if let jason = value as? [String : Any] {
//                    let email = jason["user"] as! String
//                    let token = jason["token"] as! String
//                    self.userEmail = email
//                    self.autohToken = token
//                    self.isloggedin = true
//                    completion(true)
//                }
//            case .failure(let error) :
//                debugPrint(error)
//                completion(false)
//            }
            switch response.result {
            
            case .success(let data) :
                let jason = JSON(data)
                self.userEmail = jason["user"].stringValue
                self.autohToken = jason["token"].stringValue
                self.isloggedin = true
                completion(true)
            case .failure(let error):
                debugPrint(error)
                completion(false)
         
                
            }
           
        }
        
    }
    
    func createUser(name:String, email:String, avatarName:String, avatarColor:String, completion : @escaping completionHandler) {
        let lowercaseEmail = email.lowercased()
        let body : [String : Any] = [
            "name": name,
            "email": lowercaseEmail,
            "avatarname" : avatarName,
            "avatarColor" : avatarColor
        ]
        AF.request(URl_CreateUser, method: .post, parameters: body, encoding: JSONEncoding.default, headers: CreateUserHeader).responseJSON { (response) in
            switch response.result {
            case .success(let data) :
                let json = JSON(data)
                let id = json["_id"].stringValue
                let color = json["avatarColor"].stringValue
                let avatarName = json["avatarName"].stringValue
                let email = json["email"].stringValue
                let name = json["name"].stringValue
                UserDataServices.instance.setUserDataServices(id: id, email: email, avatarName: avatarName, name: name, avatarColor: color)
                completion(true)
            case .failure(let error):
                debugPrint(error)
                completion(false)
            }
        }
    }
    
}
