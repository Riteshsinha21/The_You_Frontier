//
//  NewsModel.swift
//  The_You_Frontier
//
//  Created by Chawtech on 13/02/24.
//

import Foundation


struct NewsModel :Codable{
    let status: Bool?
    let message: String?
    let data: [NewsData]?
    let error: FrontierError?
}

struct NewsData :Codable{
    let id: Int?
    let title, description, image_url, created_at: String?
    let updated_at: String?
}

