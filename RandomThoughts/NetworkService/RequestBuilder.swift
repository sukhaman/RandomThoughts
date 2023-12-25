//
//  RequestBuilder.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/22/23.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

struct RequestBuilder {
    
    static func get(from url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        // MARK: Add Header as needed
       // request.allHTTPHeaderFields = [:]
        request.httpMethod = RequestMethod.get.rawValue
        return request
    }
    
    static func post<T: Decodable>(from url: URL, model: T) -> URLRequest where T : Encodable {
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        request.httpMethod = RequestMethod.post.rawValue
        // MARK: Add Header as needed
       // request.allHTTPHeaderFields = [:]
        return request
    }
    
    private func bodyRequest<T>(_ model: T) throws -> Data? where T: Encodable {
        return try? JSONEncoder().encode(model)
    }
}
