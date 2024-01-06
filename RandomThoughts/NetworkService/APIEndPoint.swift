//
//  APIEndPoint.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/22/23.
//

import Foundation

protocol APIEndPointProtocol {
    static var baseURL: URL {get}
}

enum APIEndpoint: RawRepresentable, APIEndPointProtocol {
    // Replace these URLs with your actual API endpoint URLs
    
    static var baseURL: URL = URL(string: "https://api.example.com/")!
    
    init?(rawValue: String) {nil}
    

    case login
    case getUser(_ id: String)
    case postComment(_ postID: String)
    case forgotPassword
    case getDeal

    var rawValue: String {
        switch self {
        case .login: return "login/"
        case .forgotPassword: return "forgotpassword/"
        case .getUser(let id): return "users/\(id)/"
        case .postComment(let postID): return "posts/\(postID)/comments/"
        case .getDeal: return "deal/"
        }
    }

}
extension RawRepresentable where RawValue == String, Self: APIEndPointProtocol {
    var url: URL {Self.baseURL.appendingPathComponent(rawValue, conformingTo: .data)}
}

extension URL {
    func appending(_ queryItem: String, value: String) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else {return absoluteURL}
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        let queryItem = URLQueryItem(name: queryItem, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}
