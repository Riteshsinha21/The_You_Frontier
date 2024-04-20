//
//  ProfileModel.swift
//  The_You_Frontier
//
//  Created by Chawtech on 29/01/24.
//

import Foundation

struct ProfileParams :Encodable {
    var name :String?
    var mobile :String?

}

struct ProfileModel: Codable {
    let status: Bool?
    let message: String?
    let data: ProfileData?

}

struct ProfileData :Codable{
    let id: Int?
    let name, mobile, email, createdAt: String?
    let updatedAt: String?
}

