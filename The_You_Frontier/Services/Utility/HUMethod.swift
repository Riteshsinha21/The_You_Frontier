//
//  HUMethod.swift
//  The_You_Frontier
//
//  Created by Chawtech on 09/01/24.
//

import Foundation

enum HttpMethod : String {
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"

}

public enum HttpError : Error {
    case jsonDecoding
    case noData
    case nonSuccessStatusCode
    case serverError
    case emptyCollection
    case emptyObject
    case invalidURL
    case missingData
}

