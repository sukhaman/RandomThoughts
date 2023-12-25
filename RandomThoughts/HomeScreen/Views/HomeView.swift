//
//  HomeView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/23/23.
//

import SwiftUI

struct HomeView: View {
    var user: User
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    var body: some View {
        
        if authenticationManager.isAuthenticated {
            CustomTabView(user: user)
        } else {
            LoginView(viewModel: LoginViewModel(MockLoginService()))
        }

        
    }
}

struct CustomTabView: View {
    var user: User
    var body: some View {
        TabView {
            // First Tab
            
            ContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            // Second Tab
            Text("Second Tab")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
            
            // Third Tab
            ProfileView(user: user)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}




#Preview {
    HomeView(user: User(id: 2, firstName: "First", lastName: "Last", username: "First Last", email: "john.doe@example.com"))
}
