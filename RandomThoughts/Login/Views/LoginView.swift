//
//  LoginView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/22/23.
//

import SwiftUI
import Combine

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @State private var isLoggedIn = false
    @State private var viewData: User?
    @State var showAlert = false
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Image(systemName: "person.circle.fill")
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(width: 100, height: 100)
                                       .foregroundColor(.green)
                                       .padding()
                    
                        TextField("Username", text: $viewModel.username)
                            .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.white)
                                            .cornerRadius(8)
                                            .shadow(radius: 3)

                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white)
                                                .cornerRadius(8)
                                                .shadow(radius: 3)
                    
                    
                    
                    Button(action: {
                        viewModel.fetchLoginData()
                    }) {
                        Text("Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .shadow(radius: 3)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
                        
                    }
                   
                    .fullScreenCover(isPresented: $isLoggedIn) {
                        if let viewData {
                            HomeView(user: viewData)
                        }
                    }
                    
                }
                
                .opacity(isLoggedIn ? 0 : 1)
                .padding()
                .onChange(of: viewModel.userData) { newData in
                    // Update the @State property when the ViewModel's @Published property changes
                    viewData = newData
                    isLoggedIn = true
                    authenticationManager.isAuthenticated = true
                }
                .onChange(of: viewModel.errorMessage) {
                    error in
                    if error != nil {
                        showAlert = true
                    }
                }
                
            }
            .ignoresSafeArea()
        }
        
        .navigationViewStyle(.stack)
        
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(MockLoginService()))
    }
}
