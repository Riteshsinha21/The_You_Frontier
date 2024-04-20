//
//  HttpUtility.swift
//  The_You_Frontier
//
//  Created by Chawtech on 09/01/24.
//


import Foundation

class HttpUtility {
    static let shared = HttpUtility()
    
    func fetchAlbumWithAsyncURLSession<T:Decodable>(url:String) async throws -> T {
        
        guard let url = URL(string:url) else {
            throw HttpError.invalidURL
        }
        
        // Use the async variant of URLSession to fetch data
        // Code might suspend here
        let (data, _) = try await URLSession.shared.data(from: url)
        
        
        // Parse the JSON data
        let iTunesResult = try JSONDecoder().decode(T.self, from: data)
        return iTunesResult
    }
    
    func getOperation<T:Decodable>(requestUrl: String, response: T.Type) async throws -> T{
        
        guard let url = URL(string:requestUrl) else {
            throw HttpError.invalidURL
        }
        
        var token = kUserDefaults.value(forKey: AppKeys.token)!
        let tokenData = "Bearer \(token)"
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tokenData , forHTTPHeaderField: "Authorization") //
        
        
        do {
            let (serverData, serverUrlResponse) = try await URLSession.shared.data(for:request)
            
            guard let httpStausCode = (serverUrlResponse as? HTTPURLResponse)?.statusCode,
                  (200...599).contains(httpStausCode) else {
                throw HttpError.nonSuccessStatusCode
            }
            
            return try JSONDecoder().decode(response.self, from: serverData)
        } catch  {
            throw error
        }
    }
    
    //MARK:- Post Api services
    
    func postOperation<T:Decodable>(sendHeader:Bool,requestMethod:HttpMethod,params:Encodable,requestUrl: String, response: T.Type) async throws -> T{
        
        guard let url = URL(string:requestUrl) else {
            throw HttpError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        if sendHeader {
            var token = kUserDefaults.value(forKey: AppKeys.token)!
            let tokenData = "Bearer \(token)"
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(tokenData , forHTTPHeaderField: "Authorization") //
        }
        
        request.httpMethod = requestMethod.rawValue//"POST"
        request.allHTTPHeaderFields = Header.header
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(params) {
            if String(data: jsonData, encoding: .utf8) != nil {
                request.httpBody = jsonData
            }
        }
        
        do {
            let (serverData, serverUrlResponse) = try await URLSession.shared.data(for:request)
            
            guard let httpStausCode = (serverUrlResponse as? HTTPURLResponse)?.statusCode,
                  (200...499).contains(httpStausCode) else {
                throw HttpError.nonSuccessStatusCode
            }
            
            return try JSONDecoder().decode(response.self, from: serverData)
        } catch  {
            throw error
        }
    }
    
    
    //MARK:- Multipart Api services
    
    
    /*
     func multiPartOperation<T:Decodable>(sendJson:uploadDocModel,requestUrl: String,fileName: String, imageUrl:URL, response: T.Type) async throws -> T{
     
     guard let url = URL(string:requestUrl) else {
     throw AlbumsFetcherError.invalidURL
     }
     
     
     var urlRequest = URLRequest(url: url)
     let lineBreak = "\r\n"
     urlRequest.httpMethod = "POST"
     
     let boundary = "---------------------------------\(UUID().uuidString)"
     urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "content-type")
     
     
     let fname = "test.png"
     let mimetype = "image/png"
     
     var requestData = Data()
     
     requestData.append("--\(boundary)\r\n" .data(using: .utf8)!)
     requestData.append("content-disposition: form-data; name=\"user_id\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
     requestData.append(sendJson.userId! .data(using: .utf8)!)
     
     requestData.append("--\(boundary)\r\n" .data(using: .utf8)!)
     requestData.append("content-disposition: form-data; name=\"user_id\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
     requestData.append(sendJson.docName! .data(using: .utf8)!)
     
     requestData.append("--\(boundary)\r\n" .data(using: .utf8)!)
     requestData.append("content-disposition: form-data; name=\"user_id\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
     requestData.append(sendJson.memberId! .data(using: .utf8)!)
     
     requestData.append("--\(boundary)\r\n" .data(using: .utf8)!)
     requestData.append("content-disposition: form-data; name=\"user_id\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
     requestData.append(sendJson.uploadedBy! .data(using: .utf8)!)
     
     
     
     requestData.append("--\(boundary)\r\n" .data(using: .utf8)!)
     requestData.append("content-disposition: form-data; name=\"imageUrl\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
     requestData.append(imageUrl.absoluteString)
     
     //            multipartFormData.append(url, withName: fileName)
     
     
     //
     //        requestData.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
     //        requestData.append("Content-Disposition:form-data; name=\"image\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
     //        requestData.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
     //        requestData.append(imageUrl)
     requestData.append("\r\n".data(using: String.Encoding.utf8)!)
     
     requestData.append("--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
     
     urlRequest.addValue("\(requestData.count)", forHTTPHeaderField: "content-length")
     urlRequest.httpBody = requestData
     
     
     let token = kUserDefaults.object(forKey: "token") as! String
     
     urlRequest.setValue(token as! String, forHTTPHeaderField: "Access-Token")
     
     //        urlRequest.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(BaseUrl.deviceID)\",  \"appVersion\": \"1.0\",\"ipAddress\": \"sdsd\",\"macAddress\": \"\"}", "Access-Token": ""]
     //             let encoder = JSONEncoder()
     //                     if let jsonData = try? encoder.encode(sendJson) {
     //                         if String(data: jsonData, encoding: .utf8) != nil {
     //                             urlRequest.httpBody = jsonData
     //                         }
     //                     }
     
     do {
     let (serverData, serverUrlResponse) = try await URLSession.shared.data(for:urlRequest)
     
     guard let httpStausCode = (serverUrlResponse as? HTTPURLResponse)?.statusCode,
     (200...299).contains(httpStausCode) else {
     throw httpError.nonSuccessStatusCode
     }
     
     return try JSONDecoder().decode(response.self, from: serverData)
     } catch  {
     throw error
     }
     }
     
     */
}
