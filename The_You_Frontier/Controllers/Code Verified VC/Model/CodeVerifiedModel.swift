//
//  CodeVerifiedModel.swift
//  The_You_Frontier
//
//  Created by Chawtech on 22/01/24.
//

import Foundation

struct ForgotPassParams :Encodable {
    var email :String?
}

struct ResetPassParams :Encodable {
    var email :String?
    var password :String?
    var otp :String?
}


struct ForgotPassModel :Codable {
    var status :Bool?
    var message :String?
    
}

