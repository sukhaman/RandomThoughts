//
//  ProfileView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/23/23.
//

import SwiftUI


struct ProfileView: View {
    var user: User
    @EnvironmentObject private var authenticationManager: AuthenticationManager

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
            VStack {
                PersonalInfoView(user: user, width: geometry.size.width * 0.93)
                
                Button(action: {
                    // Sign out action
                      authenticationManager.signOut()
                }) {
                    Text("Sign Out")
                        .frame(width: geometry.size.width * 0.93)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                    
                }
                Spacer()
            }
                Spacer()
        }

            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
        }
    }
}

struct PersonalInfoView: View {
    var user: User
    var width: CGFloat
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Name:\n\(user.username)")
            Text("Email:\n\(user.email)")
            // Add more personal information as needed
        }
        .frame(width: width)
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
        .padding()
    }
}

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false

    func signOut() {
        // Perform sign-out logic
        isAuthenticated = false
    }
}


#Preview {
    ProfileView(user: User(id: 12, firstName: "First", lastName: "Last", username: "very long can herfe hre just in case let see", email: "john.doe@example.com"))
}
