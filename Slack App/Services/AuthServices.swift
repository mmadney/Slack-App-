//
//  AuthServices.swift
//  Slack App
//
//  Created by Mohamed on 3/14/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import Foundation
import Alamofire

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
            return defualts.bool(forKey: userEmail)
        }
        set {
            defualts.set(newValue, forKey: userEmail)
        }
    }
    
    func registerUser(email : String, password : String, completion : @escaping completionHandler) {
        let lowecaseEmail = email.lowercased()
        let header : HTTPHeaders = ["Content_type": "application/json; charset=utf-8" ]
        let body  = ["email": lowecaseEmail , "password" : password ]
        AF.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.error == nil {
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }
    

    
    
}
