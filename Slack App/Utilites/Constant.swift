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
let Base_Url = "https://alexanria-chat-app.herokuapp.com/"
let URL_REGISTER = "\(Base_Url)v1/account/register"
let URL_LOGIN = "\(Base_Url)v1/account/login"
let URl_CreateUser = "\(Base_Url)v1/user/add"

//completion
typealias completionHandler = (_ Sucess: Bool) -> ()

//userdefualts
 let Logged_In_Key = "loggedIn"
 let tokenKey = "token"
 let bool_Email = "Email"
 let user_Email = "userEmail"
 let authoreToken = "authoreToken"

//Notifaction Constant
let Notif_UserData_DidChange = Notification.Name("notifUserDataChanged")

//Color
let placeHolderColor = #colorLiteral(red: 0.2381943686, green: 0.1323584321, blue: 0.5537753807, alpha: 0.575395976)

//Segue
let to_Account = "ToAcoount"
let unWind = "unWindToChannel"
let To_AvatarPicker  = "ToAvatarPicker "
let to_Login = "to_Login"

//Header
let Header : HTTPHeaders = ["Content_type" : "application/json; charset=utf_8"]
let CreateUserHeader : HTTPHeaders = [
    "Authorization" : "Bearer \(Authservice.instance.autohToken)",
     "Content_type" : "application/json; charset=utf_8"
]

//ReuseIdentfier
let AvatarPickerCell = "AvatarPickerCell"
