//
//  LoginService.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/22/23.
//

import Foundation
import Combine

struct LoginUser: Codable {
    let email: String
    let passwird: String
}

struct User: Equatable, Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let username: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id, username, email
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
class LoginService {
    
    func fetchLoginData(_ request: URLRequest) -> AnyPublisher<User,Error> {
        return fetchData(from: request)
    }
    
    func fetchProfileData(_ request: URLRequest) -> AnyPublisher<User,Error> {
        return fetchData(from: request)
    }
    
    func fetchForgotPasswordData(_ request: URLRequest) -> AnyPublisher<Data,Error> {
        return fetchData(from: request)
    }
    
    
    func fetchData<T: Decodable>(from request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
