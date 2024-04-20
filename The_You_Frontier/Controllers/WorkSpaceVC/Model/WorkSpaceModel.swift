//
//  WorkSpaceModel.swift
//  The_You_Frontier
//
//  Created by Chawtech on 01/02/24.
//

import Foundation

struct WorkSpaceLocationModel : Encodable {
    var lat:String
    var lng:String
}


struct WorkSpaceListModel :Codable {
    let status: Bool?
    let message: String?
    let data: [WorkSpaceData]?
    let error: FrontierError?
}


struct WorkSpaceData :Codable {
    let id: Int?
    let title, description, location, lat: String?
    let lng, created_at, updated_at: String?
    let image_url: [String]?
}

// MARK: - Error
struct FrontierError :Codable {
}


