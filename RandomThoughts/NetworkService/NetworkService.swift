//
//  NetworkService.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/22/23.
//

import Foundation
import Combine

protocol NetworkService {
    func fetchData<T: Decodable>(from url: URLRequest) -> AnyPublisher<T, Error>
}


