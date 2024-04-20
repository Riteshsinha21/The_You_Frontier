//
//  LoginModel.swift
//  The_You_Frontier
//
//  Created by Chawtech on 19/01/24.
//

import Foundation

struct LoginParams:Encodable {
    var email: String?
    var password: String?
    var device_token: String?
}


struct LoginModel:Codable {
    let status: Bool?
    let message: String?
    let data: LoginData?
    let token: String?
}

// MARK: - DataClass
struct LoginData :Codable{
    let id: Int?
    let name, mobile, email, createdAt: String?
    let updatedAt: String?
}


