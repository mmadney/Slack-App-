//
//  File.swift
//  Slack App
//
//  Created by Mohamed on 3/13/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import Foundation
import Alamofire

//URL Constant
let Base_Url = "http://localhost:3005/v1/"
let URL_REGISTER = "\(Base_Url)account/register"
let URL_LOGIN = "\(Base_Url)account/login"
//completion
typealias completionHandler = (_ Sucess: Bool) -> ()

//userdefualts
 let Logged_In_Key = "loggedIn"
 let tokenKey = "token"
 let bool_Email = "Email"
 let user_Email = "userEmail"
 let authoreToken = "authoreToken"

//Segue
let to_Account = "ToAcoount"
let unWind = "unWindToChannel"


//Header
let Header : HTTPHeaders = ["Content_type" : "application/json; charset=utf_8"]
