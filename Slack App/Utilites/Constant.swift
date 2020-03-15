//
//  File.swift
//  Slack App
//
//  Created by Mohamed on 3/13/20.
//  Copyright © 2020 Qruz. All rights reserved.
//

import Foundation

//URL Constant
let Base_Url = "http://localhost:3005/v1/"
let URL_REGISTER = "\(Base_Url)account/register"

//completion
typealias completionHandler = (_ Sucess: Bool) -> ()

//userdefualts
 let Logged_In_Key = "loggedIn"
 let tokenKey = "token"
 let userEmail = "userEmail"

//Segue
let to_Account = "ToAcoount"
let unWind = "unWindToChannel"
