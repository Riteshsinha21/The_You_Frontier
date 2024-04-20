//
//  MessageModel.swift
//  The_You_Frontier
//
//  Created by Chawtech on 12/01/24.
//

import Foundation

struct CellData:Codable{
    var videoId:String?
    var title:String?
}

//MARRK:- Video list Model

struct VideoListModel: Codable {
    let status: Bool?
    let message: String?
    let data: [VideoList]?
    let error: FrontierError?
}

struct VideoList: Codable {
    let id: Int?
    let title: String?
    let videoURL: String?
    let videoId: String?
    let imageURL, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case videoURL = "video_url"
        case videoId = "video_id"
        case imageURL = "image_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


