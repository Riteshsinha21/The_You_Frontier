//
//  Constant.swift
//  The_You_Frontier
//
//  Created by Chawtech on 09/01/24.
//

import Foundation
import UIKit


let TYF_AppDelegate = UIApplication.shared.delegate as! AppDelegate
let deviceID = UIDevice.current.identifierForVendor!.uuidString
let kUserDefaults = UserDefaults.standard
//let kGoogleApiKey = "AIzaSyAwLRt95oBL8bC1NQdu5F_k1MApP8NT4rI"
let kGoogleApiKey = "AIzaSyCMnH4OzVzr80GizG253dU9ucFqHqSPr4Y"
//AIzaSyCMnH4OzVzr80GizG253dU9ucFqHqSPr4Y

//GMSServices.provideAPIKey("AIzaSyCEu8VAezZUzYFMZbTGCQFt37Zh9fupg3Q")

struct BaseUrl {
    static let imageBaseUrl = "https://youfrontier.chawtechsolutions.ch/public/"
    
    static let baseURL = "https://youfrontier.chawtechsolutions.ch/api/"
    static let loginURL = "auth/signin"
    static let signUpURL = "auth/signup"
    static let forgetUpURL = "auth/forget"
    static let resetPassURL = "auth/reset"
    static let logoutURL = "auth/logout"
    static let updateProfileURL = "auth/profile"
    static let changePasswordURL = "auth/changepassword"
    static let workSpaceListURL = "workspace/list"
    static let workSpaceDetailURL = "workspace/detail/"
    static let eventListURL = "event/list"
    static let eventDetailURL = "event/detail/"
    static let addIntrestURL = "event/addinterested/"
    static let newsListURL = "news/list"
    static let videoListURL = "video/list"
    
    static let becomeMemberUrl = "https://docs.google.com/forms/d/e/1FAIpQLSfHzNJDlrddkc66Tydd1O3qvEBtROAvSda44tKLtvZC4vL5AQ/viewform"
 

}

struct Header{
    static let header = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(deviceID)\",  \"appVersion\": \"1.0\",\"ipAddress\": \"sdsd\",\"macAddress\": \"\"}", "App-Token": ""]
}


//MARK:- AppKeys

struct AppKeys {

    static let tabName = "tabName"
    static let token = "token"
    static let email = "email"
    static let name = "name"
    static let phone = "phone"
}

struct TYF_AlertText {
    static let internetConnection = "Please check your internet connection !"
    static let alert  = "Alert"
    static let mobileValidation = "Please enter 10 to 13 digit Mobile Number"
    static let passValidation = "Please enter 8 to 15 digit Password"
    static let passConfirmValidation = "Please enter 8 to 15 digit Confirm Password"
    static let confirmPass = "Confirm Password"
    static let messageconfirmPass = "Please enter your confirm Password"
    static let messageNewPass = "Please enter your new Password"
    static let password = "Password"
    static let oldPassword = "Old Password"
    static let newPassword = "New Password"
    static let messagePassword = "Please enter your password"
    static let messageOldPassword = "Please enter your old password"
    static let passwordNotMatch = "Password"
    static let validPass =  "Confirm password does not match with new password"
    static let validPass1 =  "Confirm password does not match with  password"
    static let validPass12 =  "Confirm password does not match with new password"
}
