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
let URL_User_By_Email = "\(Base_Url)v1/user/byEmail/"
let URL_Get_Channel = "\(Base_Url)v1/channel"
let URL_Get_Message = "\(Base_Url)v1/message/byChannel"

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
let Notif_ChannelData_DidChange = Notification.Name("notifUserChannelsChanged")
let Notif_Channel_Selected = Notification.Name("notifChannelSelected")

//Color
let placeHolderColor = #colorLiteral(red: 0.2381943686, green: 0.1323584321, blue: 0.5537753807, alpha: 0.575395976)

//Segue
let to_Account = "ToAcoount"
let unWind = "unWindToChannel"
let To_AvatarPicker  = "ToAvatarPicker "
let to_Login = "to_Login"

//Header
let Header : HTTPHeaders = ["Content_type" : "application/json; charset=utf_8"]
let BEARER_HEADER : HTTPHeaders = [
    "Authorization" : "Bearer \(Authservice.instance.autohToken)",
     "Content_type" : "application/json; charset=utf_8"
]

//ReuseIdentfier
let AvatarPickerCell = "AvatarPickerCell"

//WebSocketEvENT
let addChannelEvent = "newChannel"
let getChhanelEvent = "channelCreated"
