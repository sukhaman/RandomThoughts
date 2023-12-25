//
//  RandomThoughtsApp.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/22/23.
//

import SwiftUI

@main
struct RandomThoughtsApp: App {
    @StateObject private var authenticationManager = AuthenticationManager()
    var body: some Scene {
        WindowGroup {
             SplashView()
                .environmentObject(authenticationManager)
        }
    }
}


struct SplashView: View {
    @State private var isSplashScreenActive = true
    @State private var rotationAngle: Double = 0
    @StateObject private var loginViewModel = LoginViewModel(MockLoginService())
    var body: some View {
        Group {
            if isSplashScreenActive {
                // Splash screen content
                Image(systemName: "star.fill")
                            .font(.system(size: 100))
                            .rotationEffect(.degrees(rotationAngle))
                            .onAppear {
                                withAnimation(Animation.linear(duration: 5)) {
                                    rotationAngle += 360
                                }
                                
                                // Simulate a delay for the splash screen
                                DispatchQueue.main.asyncAfter(deadline: .now() + 35) {
                                    withAnimation {
                                        isSplashScreenActive = false
                                    }
                                }
                            }
                            .opacity(isSplashScreenActive ? 1 : 0)
            } else {
                // Main content after splash screen
                LoginView(viewModel: LoginViewModel(MockLoginService()))
                
               
                
            }
        }
        .onAppear {
            // Simulate a delay for the splash screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isSplashScreenActive = false
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
