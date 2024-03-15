//
//  Networking.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 3/15/24.
//

import Foundation

protocol Networking {
    func makeHTTPRequest(baseURL: String,
                         path: String,
                         method: HTTPMethod,
                         queryItem: [URLQueryItem]?,
                         headers: [String: String]?,
                         body: Data?) throws -> URLRequest
}

extension Networking {
    func makeHTTPRequest(baseURL: String = Bundle.main.object(forInfoDictionaryKey: Config.baseURL) as! String,
                         path: String,
                         method: HTTPMethod,
                         queryItems: [URLQueryItem]? = nil,
                         headers: [String: String]?,
                         body: Data?) throws -> URLRequest {
        
        //URL + Path
        
        guard var urlComponents = URLComponents(string: baseURL + path) else {
            throw NetworkServiceError.badURL
        }
        if queryItems != nil {
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            throw NetworkServiceError.badURL
        }
        
        // Request
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers?.forEach({ header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        })
        
        if let body = body {
            request.httpBody = body
        }
        
        return request
    }
}
