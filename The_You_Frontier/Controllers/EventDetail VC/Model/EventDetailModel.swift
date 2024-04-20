//
//  EventDetailModel.swift
//  The_You_Frontier
//
//  Created by Chawtech on 01/02/24.
//

import Foundation

struct EventDetailModel :Codable {
    let status: Bool?
    let message: String?
    let data: EventDetailData?
    let error: FrontierError?
}

struct EventDetailData :Codable {
    let id: Int?
    let title, description, location, lat: String?
    let lng, created_at, updated_at: String?
    let image_url: [String]?
}


struct EventDetailModel2 :Codable {
    let status: Bool?
    let message: String?
    let data: EventDetailData2?
    let error: FrontierError?
}

struct EventDetailData2 :Codable {
    let id ,showinterest_count: Int?
    let name, description,event_date,event_time, location, lat: String?
    let lng, created_at, updated_at: String?
    let image_url: [String]?
}

