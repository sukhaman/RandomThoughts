//
//  MockServiceResponse.swift
//  RandomThoughtsTests
//
//  Created by Sukhaman Singh on 12/22/23.
//

import Foundation
@testable import RandomThoughts


func createUserObject() -> [String: Any?] {
    [
        "id": 1,
        "first_name": "Any",
        "last_name": "Last",
        "username": "Any username",
        "email" : "john.doe@example.com",
        "user_type": "customer"
    ]
}
