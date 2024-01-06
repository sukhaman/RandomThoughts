//
//  LoginViewModel.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/22/23.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var userData: User?
    @Published var dealListData: DealList?
    var service: LoginService
    private var canccelables: Set<AnyCancellable> = []
    init(_ service: LoginService) {
        self.service = service
    }
    func login() {
        // Basic validation
        if username.isEmpty || password.isEmpty {
            errorMessage = "Username and password are required."
        } else {
            // Perform login logic here (e.g., communicate with a server, check credentials, etc.)
            // For simplicity, let's assume a successful login here
            errorMessage = nil
        }
    }
    
    func fetchLoginData() {
        
        let loginEndpont = APIEndpoint.login.url
        let user = LoginUser(email: "any@me.com", passwird: "1234")
        let request = RequestBuilder.post(from: loginEndpont, model: user)
        let publisher = service.fetchLoginData(request)
        
        publisher
            .sink { completion  in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { user in
                self.userData = user
            }
            .store(in: &canccelables)

    }
    
    func fetchDealList() {
        
        let endpoint = APIEndpoint.getDeal.url
        let request = RequestBuilder.get(from: endpoint)
        let publisher = service.fetchDealList(request)
        
        publisher
            .sink { completion  in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { dealList in
                self.dealListData = dealList
            }
            .store(in: &canccelables)

    }
    
    func fetchUserProfile(_ id: String) {
        
        let profileEndpont = APIEndpoint.getUser(id).url
        let request = RequestBuilder.get(from: profileEndpont)
        let publisher = service.fetchProfileData(request)
        
        publisher
            .sink { completion  in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { user in
                self.userData = user
            }
            .store(in: &canccelables)

    }
    
    func fetchForgotPasswordData() {
        let loginEndpont = APIEndpoint.forgotPassword.url
        let user = LoginUser(email: "any@me.com", passwird: "1234")
        let request = RequestBuilder.post(from: loginEndpont, model: user)
        let publisher = service.fetchForgotPasswordData(request)
        
        publisher
            .sink { completion  in
                switch completion {
                case .failure(let error):
                    let errorInfo = error as NSError
                    let userInfo = errorInfo.userInfo["detail"] as? String
                    self.errorMessage = userInfo == nil ? error.localizedDescription : userInfo
                case .finished:
                    break
                }
            } receiveValue: { data in
                
            }
            .store(in: &canccelables)

    }
}
