//
//  EventModel.swift
//  The_You_Frontier
//
//  Created by Chawtech on 08/02/24.
//

import Foundation

struct EventModel :Codable{
    let status: Bool?
    let message: String?
    let data: [EventData]?
    let error: FrontierError?
}

struct EventData :Codable{
    let id, showinterest_count: Int?
    let name, event_date, event_time, description: String?
    let location, lat, lng: String?
    let image_url: [String]?
    let updated_at, created_at: String?
}

