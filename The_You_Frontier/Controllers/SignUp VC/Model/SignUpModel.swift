//
//  SignUpModel.swift
//  The_You_Frontier
//
//  Created by Chawtech on 19/01/24.
//

import Foundation

struct SignInParams :Encodable{
    var name : String?
    var email : String?
    var mobile : String?
    var password : String?

}


struct SignInModel: Codable {
    let status: Bool?
    let message: String?
    let data: SignInData?
    let token: String?
}

struct SignInData :Codable{
    let id: Int?
    let name, mobile, email, createdAt: String?
    let updatedAt: String?
}


