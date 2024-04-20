//
//  ChangePasswordModel.swift
//  The_You_Frontier
//
//  Created by Chawtech on 29/01/24.
//

import Foundation

struct ChangePassParams :Encodable {
    var current_password :String?
    var new_password :String?
    
}


struct ChangePassModel :Codable{
    let status: Bool?
    let message: String?
    let data: ChangePassData?
    //let error: Error?
}

struct ChangePassData :Codable{
    let id: Int?
    let roleID, name, email, mobile: String?
    let userType: String?
    let userProfile: String?
    let userStatus: Int?
    let userAbout, userOtherDetails, userUniqName, authSource: String?
    let authID: String?
    let verificationCode, deviceToken: String?
    let firebaseToken, emailVerifiedAt, createdAt: String?
    let updatedAt: String?
}

