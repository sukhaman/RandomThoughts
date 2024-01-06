//
//  MockLoginService.swift
//  RandomThoughtsTests
//
//  Created by Sukhaman Singh on 12/22/23.
//

import Foundation
import Combine
@testable import RandomThoughts

class MockLoginService: LoginService {
    var dataToReturn: Data?
    var errorToReturn: Error?
    
    override func fetchData<T>(from request: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        if let url = request.url {
            switch url {
            case APIEndpoint.login.url:
                  dataToReturn = try! JSONSerialization.data(withJSONObject: createUserObject())
            case APIEndpoint.getUser(String("1")).url:
                let token = request.value(forHTTPHeaderField: "Authorization")
                  if token  == nil {
                      errorToReturn = AppError.unauthorized
                  } else {
                      dataToReturn = try! JSONSerialization.data(withJSONObject: createUserObject())
                  }
            case APIEndpoint.getDeal.url:
                let result = ["results": [createDealListObject()]]
                let data = try! JSONSerialization.data(withJSONObject: result)
                dataToReturn = data
            default:
                errorToReturn = NSError(domain: "Bad Request", code: 42, userInfo: ["detail": "You have provider wrong email"])
            }
        }
        if let error = errorToReturn {
            return Fail(error: error).eraseToAnyPublisher()
        } else if let data = dataToReturn {
        
                return Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError({_ in AppError.badRequest})
                    .eraseToAnyPublisher()
           
        } else {
            fatalError("Either dataToReturn or errorToReturn must be set in the mock.")
        }
        
    }
}

enum AppError: LocalizedError {
    case badRequest
    case networkError
    case serverError(String)  // Include a custom error message for server errors
    case parsingError
    case unauthorized
    case custom(String)       // Include a catch-all case for custom error messages

    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .networkError:
            return "Network error. Please check your internet connection and try again."
        case .serverError(let message):
            return "Server error: \(message)"
        case .parsingError:
            return "Error parsing data. Please try again later."
        case .unauthorized:
            return "Unauthorized access. Please log in again."
        case .custom(let message):
            return message
        }
    }
}
