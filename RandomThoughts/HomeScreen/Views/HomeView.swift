//
//  HomeView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/23/23.
//

import SwiftUI

struct HomeView: View {
    var user: User
    var dealList: DealList
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    var body: some View {
        
        if authenticationManager.isAuthenticated {
            SplitView(user: user,dealList: dealList)
        } else {
            LoginView(viewModel: LoginViewModel(MockLoginService()))
        }

        
    }
}


#Preview {
    HomeView(user: User(id: 3, firstName: "First", lastName: "Last", username: "Usernam", email: "emai@test.com"), dealList: DealList(results: [Deal(id: 1, status: "active", buyer: User(id: 3, firstName: "First", lastName: "Last", username: "Usernam", email: "emai@test.com"))]))
}
