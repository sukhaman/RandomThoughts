//
//  LoginViewModelTests.swift
//  RandomThoughtsTests
//
//  Created by Sukhaman Singh on 12/22/23.
//

import Foundation
@testable import RandomThoughts
import XCTest

class LoginViewModelTests: XCTestCase {
    
    func test_login_invalidRequest() {
        let service = MockLoginService()
        let viewModel = LoginViewModel(service)
       viewModel.fetchUserProfile(String("1"))
        let expectedError = AppError.unauthorized.localizedDescription
        let actualError = viewModel.errorMessage
        XCTAssertEqual(actualError, expectedError)
    }
    
    func test_login_invalidRequestForForgotPassword() {
        let service = MockLoginService()
        let viewModel = LoginViewModel(service)
        viewModel.fetchForgotPasswordData()
        XCTAssertEqual(viewModel.errorMessage, "You have provider wrong email")
    }
    
    func test_login_validRequest() {
        let service = MockLoginService()
        let viewModel = LoginViewModel(service)
        viewModel.fetchLoginData()
        
        let actualResult = viewModel.userData
        XCTAssertNotNil(actualResult)
    }
}
